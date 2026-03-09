# GroundZero

Sistem za upravljanje teretanom — backend API, mobilna aplikacija za članove i desktop aplikacija za administraciju.

## Tech Stack

| Komponenta | Tehnologija |
|------------|-------------|
| Backend API | .NET 8.0 (C#), SQL Server, MediatR (CQRS), FluentValidation |
| Mobilna aplikacija | Flutter (Dart), Riverpod, GoRouter |
| Desktop aplikacija | Flutter (Dart), Riverpod, GoRouter |
| Plaćanje | Stripe |
| Messaging | RabbitMQ |
| Email | SMTP (Gmail) |

## Struktura projekta

```
GroundZero/
├── src/
│   ├── GroundZero.API/            — Web API (controllers, middleware)
│   ├── GroundZero.Application/    — Use cases, CQRS, validacija
│   ├── GroundZero.Domain/         — Entiteti, enumeracije
│   ├── GroundZero.Infrastructure/ — Baza, repozitoriji, vanjski servisi
│   └── GroundZero.Messaging/      — RabbitMQ worker
├── groundzero_mobile/             — Flutter mobilna aplikacija
└── groundzero_desktop/            — Flutter desktop aplikacija
```

## Pristupni podaci

**Admin (Desktop aplikacija):**
- Username: `desktop`
- Password: `test`

**Test korisnik (Mobilna aplikacija):**
- Email: `user@test.com`
- Password: `test`

## Pokretanje

### Preduvjeti

- [Docker](https://www.docker.com/products/docker-desktop/)
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.10+)

### 1. Backend (API + baza + RabbitMQ)

```
GroundZero/          <-- pozicioniraj se ovdje
├── docker-compose.yml
├── .env
```

```bash
docker-compose up --build
```

Pokreće SQL Server, RabbitMQ, API i Worker servis. API je dostupan na `http://localhost:5147` (Swagger: `/swagger`).

### 2. Mobilna aplikacija

```
GroundZero/
├── groundzero_mobile/    <-- pozicioniraj se ovdje
```

```bash
flutter pub get
flutter run
```

### 3. Desktop aplikacija

```
GroundZero/
├── groundzero_desktop/   <-- pozicioniraj se ovdje
```

```bash
flutter pub get
flutter run -d windows
```
