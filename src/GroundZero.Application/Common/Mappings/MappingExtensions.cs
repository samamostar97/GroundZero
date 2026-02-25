namespace GroundZero.Application.Common.Mappings;

public static class MappingExtensions
{
    public static TDestination MapTo<TDestination>(this object source)
        where TDestination : new()
    {
        var destination = new TDestination();
        var sourceProperties = source.GetType().GetProperties();
        var destinationProperties = typeof(TDestination).GetProperties();

        foreach (var destProp in destinationProperties)
        {
            var sourceProp = sourceProperties
                .FirstOrDefault(p => p.Name == destProp.Name && p.PropertyType == destProp.PropertyType);

            if (sourceProp != null && destProp.CanWrite)
            {
                destProp.SetValue(destination, sourceProp.GetValue(source));
            }
        }

        return destination;
    }

    public static List<TDestination> MapToList<TDestination>(this IEnumerable<object> source)
        where TDestination : new()
    {
        return source.Select(s => s.MapTo<TDestination>()).ToList();
    }
}
