# SimulatorECU

Desktop ECU diagnostics and tuning simulator built with **Java 21**, **JavaFX**, and **Maven**.  
Users select a vehicle, review diagnostics, apply presets, and explore tuning in an interactive workflow.

> **Current status:** Welcome screen and vehicle selection (manufacturer → make → model) are implemented. SQLite integration and diagnostics screen are in progress.

---

## Features

### Implemented
- Welcome screen with navigation to vehicle selection
- Dependent dropdowns: Manufacturer → Make → Model
- Selected vehicle summary
- Layered JavaFX + Maven project structure

### Planned
- SQLite-backed vehicle and ECU base map data
- Rule-based diagnostics (DTC-style fault codes)
- Suggested fixes and clear-codes workflow
- Performance presets (fuel efficient, max power, balanced, random faulted)
- Tuning screen with RPM simulation and engine audio

---

## Tech Stack

| Layer | Technology |
|--------|------------|
| Language | Java 21 |
| UI | JavaFX (FXML) |
| Build | Maven |
| Database | SQLite (JDBC) — upcoming |
| IDE | IntelliJ IDEA |

---

## Screenshots

<!-- Add screenshots when ready -->
<!-- Example: -->
<!-- ![Vehicle Selection](docs/screenshots/vehicle-selection.png) -->

*Screenshots coming soon.*

---

## Prerequisites

- **JDK 21** (e.g. Eclipse Temurin)
- **Git** (optional, for clone)
- No global Maven install required — project includes Maven Wrapper (`mvnw`)

---

## Getting Started

### Clone the repository

```bash
git clone https://github.com/bariqqazi11/SimulatorECU.git
cd SimulatorECU
