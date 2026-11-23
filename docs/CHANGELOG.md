# Registro de Cambios (CHANGELOG) - BarberFlow

## [v1.2.0] - 2026-11-20 (Tercer Corte)
### Agregado
- Panel administrativo de estadísticas (citas del día, completadas, canceladas, servicios top).
- Validación de máquina de estados de citas (`RESERVADA -> CLIENTE_LLEGO -> EN_ATENCION -> FINALIZADA`).
- Controles de seguridad OWASP Top 10 (RBAC con JWT, hashing bcrypt, consultas parametrizadas).

## [v1.1.0] - 2026-10-15 (Segundo Corte)
### Agregado
- Módulo de reservas con validación de disponibilidad en tiempo real (CR-001).
- Registro de preferencias de corte por cliente.

## [v1.0.0] - 2026-09-10 (Primer Corte)
### Agregado
- Esquema inicial de base de datos relacional (`usuarios`, `clientes`, `barberos`, `servicios`, `reservas`).
- Autenticación base y gestión de catálogo de servicios.
