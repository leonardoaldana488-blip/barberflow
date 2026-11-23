# BarberFlow - Sistema Web de Gestión y Reservas para Barberías

**Institución:** Corporación Universitaria Minuto de Dios – UNIMINUTO  
**Asignatura:** Ingeniería de Software (NRC: 60-85391)  
**Docente:** César Lavarcude  
**Integrantes:** Jorge Ospino (Project Manager / Frontend / QA) & Cristian Aldana (Product Owner / Scrum Master / Backend)  
**Año:** 2026

## Descripción del Proyecto
**BarberFlow** es una aplicación web diseñada para centralizar la gestión de clientes, catálogo de servicios, asignación de barberos y control de estados de citas en tiempo real (`Reservada -> Cliente llegó -> En atención -> Finalizada / Cancelada`).

## Arquitectura y Estructura del Repositorio
```text
barberflow/
├── frontend/
│   └── index.html          # Interfaz web responsiva (Cliente, Barbero, Administrador)
├── backend/
│   └── server.js           # API RESTful con Node.js / Express y seguridad JWT/RBAC
├── database/
│   └── schema.sql          # Modelo relacional normalizado en MySQL 8.0
└── docs/
    └── CHANGELOG.md        # Registro de versiones (SemVer v1.0.0 - v1.2.0)
```

## Seguridad Implementada (SDLC Seguro - OWASP Top 10)
- **A01 Broken Access Control:** Middleware RBAC (`Cliente`, `Barbero`, `Administrador`).
- **A02 Cryptographic Failures:** Hashing de contraseñas con `bcrypt` (cost factor 12).
- **A03 Injection:** Consultas parametrizadas (`Prepared Statements`) y sanitización de entradas.
- **A07 Identification and Authentication Failures:** Tokens JWT con expiración controlada.

## Instalación Rápida
1. Ejecutar `database/schema.sql` en MySQL 8.0.
2. Configurar variables en `.env` e instalar dependencias en `backend/` (`npm install express mysql2 bcrypt jsonwebtoken helmet cors`).
3. Iniciar servidor con `node backend/server.js` y abrir `frontend/index.html`.
