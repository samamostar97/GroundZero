# GroundZero

Full-stack: .NET 8 Clean Architecture + Flutter 3-Package Monorepo.

## Structure
```
GroundZero/
+-- GroundZero.sln
+-- GroundZero/                     <- .NET 8 Backend
+-- ground_zero_flutter/
    +-- ground_zero_core/            <- Shared Dart package
    +-- ground_zero_desktop/         <- Admin (Windows/macOS/Linux)
    +-- ground_zero_mobile/          <- Member (Android/iOS)
```

## Backend
```bash
dotnet ef migrations add Init -p GroundZero/GroundZero.Infrastructure -s GroundZero/GroundZero.API
dotnet ef database update -p GroundZero/GroundZero.Infrastructure -s GroundZero/GroundZero.API
dotnet run --project GroundZero/GroundZero.API
```
Admin: admin@example.com / Admin123!  |  Swagger: https://localhost:7001/swagger

## Frontend
```bash
cd ground_zero_flutter/ground_zero_desktop && flutter pub get && flutter run
cd ground_zero_flutter/ground_zero_mobile && flutter pub get && flutter run
```
