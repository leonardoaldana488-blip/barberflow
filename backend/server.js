const express = require('express');
const helmet = require('helmet');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const app = express();
app.use(helmet());
app.use(cors());
app.use(express.json({ limit: '10kb' }));

const JWT_SECRET = process.env.JWT_SECRET || 'barberflow_uniminuto_2026_secret';

// Middleware RBAC
function autorizarRoles(...rolesPermitidos) {
  return (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (!authHeader) return res.status(401).json({ error: 'Token requerido' });
    const token = authHeader.split(' ')[1];
    try {
      const payload = jwt.verify(token, JWT_SECRET);
      if (!rolesPermitidos.includes(payload.rol)) {
        return res.status(403).json({ error: 'Acceso denegado para este rol' });
      }
      req.user = payload;
      next();
    } catch (err) {
      return res.status(401).json({ error: 'Token inválido o expirado' });
    }
  };
}

// Endpoint de salud y catálogo
app.get('/api/servicios', (req, res) => {
  res.json([
    { id: 1, nombre: 'Corte de cabello', precio: 20000, duracion: 30 },
    { id: 2, nombre: 'Servicio de barba', precio: 15000, duracion: 20 },
    { id: 3, nombre: 'Corte + barba', precio: 32000, duracion: 45 },
    { id: 4, nombre: 'Corte infantil', precio: 16000, duracion: 25 }
  ]);
});

// Validación de máquina de estados de cita
const TRANSICIONES_VALIDAS = {
  RESERVADA: ['CLIENTE_LLEGO', 'CANCELADA'],
  CLIENTE_LLEGO: ['EN_ATENCION', 'CANCELADA'],
  EN_ATENCION: ['FINALIZADA'],
  FINALIZADA: [],
  CANCELADA: []
};

app.patch('/api/reservas/:id/estado', autorizarRoles('BARBERO', 'ADMINISTRADOR'), (req, res) => {
  const { estadoActual, nuevoEstado } = req.body;
  if (!TRANSICIONES_VALIDAS[estadoActual]?.includes(nuevoEstado)) {
    return res.status(400).json({ error: `Transición inválida de ${estadoActual} a ${nuevoEstado}` });
  }
  res.json({ id: req.params.id, estado: nuevoEstado, actualizadoPor: req.user.correo });
});

app.listen(3000, () => console.log('BarberFlow API corriendo en puerto 3000'));
