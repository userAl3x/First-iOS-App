# Bullseye Game

Juego iOS en SwiftUI donde debes acertar un número objetivo usando un slider.

## Descripción

Aplicación simple donde el jugador mueve un slider (1-100) para intentar acercarse a un número aleatorio. Cuanto más cerca, más puntos.

## Funcionalidades

- Número objetivo aleatorio (1-100)
- Slider para seleccionar valor
- Sistema de puntuación
- Múltiples rondas
- Historial de partidas
- Botón de reinicio

## Puntuación

- Exacto: 200 puntos
- Diferencia ≤5: 150 puntos
- Diferencia ≤10: 100 puntos
- Otros: 100 - diferencia

## Arquitectura

```
Models/
  └── Game.swift           # Lógica del juego
Views/
  ├── ContentView.swift    # Pantalla principal
  └── LeaderboardView.swift # Historial
```

## Tecnologías

- SwiftUI
- Swift
- Xcode

## Requisitos

- iOS 15.0+
- Xcode 14.0+

## Instalación

1. Abrir el proyecto en Xcode
2. Seleccionar simulador o dispositivo
3. Ejecutar con `Cmd + R`

---

Proyecto educativo - M08 Programación Multimedia y Dispositivos Móviles
