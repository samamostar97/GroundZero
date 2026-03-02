using FluentAssertions;
using FluentValidation;
using FluentValidation.Results;
using GroundZero.Application.Common;
using MediatR;
using NSubstitute;
using ValidationException = GroundZero.Application.Exceptions.ValidationException;

namespace GroundZero.Application.Tests.Common;

public class ValidationBehaviorTests
{
    private static RequestHandlerDelegate<T> NextReturning<T>(T value)
        => ct => Task.FromResult(value);

    [Fact]
    public async Task Handle_NoValidators_ShouldCallNext()
    {
        // Arrange
        var validators = Enumerable.Empty<IValidator<TestCommand>>();
        var behavior = new ValidationBehavior<TestCommand, string>(validators);

        // Act
        var result = await behavior.Handle(new TestCommand(), NextReturning("ok"), CancellationToken.None);

        // Assert
        result.Should().Be("ok");
    }

    [Fact]
    public async Task Handle_ValidRequest_ShouldCallNext()
    {
        // Arrange
        var validator = Substitute.For<IValidator<TestCommand>>();
        validator.ValidateAsync(Arg.Any<ValidationContext<TestCommand>>(), Arg.Any<CancellationToken>())
            .Returns(new ValidationResult());

        var behavior = new ValidationBehavior<TestCommand, string>(new[] { validator });

        // Act
        var result = await behavior.Handle(new TestCommand(), NextReturning("valid"), CancellationToken.None);

        // Assert
        result.Should().Be("valid");
    }

    [Fact]
    public async Task Handle_InvalidRequest_ShouldThrowValidationException()
    {
        // Arrange
        var validator = Substitute.For<IValidator<TestCommand>>();
        var failures = new List<ValidationFailure>
        {
            new("Name", "Naziv je obavezan."),
            new("Price", "Cijena mora biti veća od 0.")
        };
        validator.ValidateAsync(Arg.Any<ValidationContext<TestCommand>>(), Arg.Any<CancellationToken>())
            .Returns(new ValidationResult(failures));

        var behavior = new ValidationBehavior<TestCommand, string>(new[] { validator });

        // Act
        var act = () => behavior.Handle(new TestCommand(), NextReturning(""), CancellationToken.None);

        // Assert
        var ex = await act.Should().ThrowAsync<ValidationException>();
        ex.Which.Errors.Should().HaveCount(2);
        ex.Which.Errors.Should().Contain("Naziv je obavezan.");
        ex.Which.Errors.Should().Contain("Cijena mora biti veća od 0.");
    }

    [Fact]
    public async Task Handle_MultipleValidatorsOneInvalid_ShouldThrowValidationException()
    {
        // Arrange
        var validator1 = Substitute.For<IValidator<TestCommand>>();
        validator1.ValidateAsync(Arg.Any<ValidationContext<TestCommand>>(), Arg.Any<CancellationToken>())
            .Returns(new ValidationResult());

        var validator2 = Substitute.For<IValidator<TestCommand>>();
        validator2.ValidateAsync(Arg.Any<ValidationContext<TestCommand>>(), Arg.Any<CancellationToken>())
            .Returns(new ValidationResult(new[] { new ValidationFailure("Field", "Greška.") }));

        var behavior = new ValidationBehavior<TestCommand, string>(new[] { validator1, validator2 });

        // Act
        var act = () => behavior.Handle(new TestCommand(), NextReturning(""), CancellationToken.None);

        // Assert
        var ex = await act.Should().ThrowAsync<ValidationException>();
        ex.Which.Errors.Should().ContainSingle().Which.Should().Be("Greška.");
    }

    public class TestCommand : IRequest<string> { }
}
