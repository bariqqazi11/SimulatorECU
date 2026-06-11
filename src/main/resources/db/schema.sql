PRAGMA foreign_keys = ON;

-- ===============
-- Core hierarchy
-- ===============
CREATE TABLE IF NOT EXISTS manufacturers (
                                             id          INTEGER PRIMARY KEY AUTOINCREMENT,
                                             name        TEXT NOT NULL UNIQUE,
                                             logo_path   TEXT
);

CREATE TABLE IF NOT EXISTS makes (
                                     id              INTEGER PRIMARY KEY AUTOINCREMENT,
                                     manufacturer_id INTEGER NOT NULL,
                                     name            TEXT NOT NULL,
                                     logo_path       TEXT,
                                     UNIQUE (manufacturer_id, name),
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS car_models (
                                          id              INTEGER PRIMARY KEY AUTOINCREMENT,
                                          make_id         INTEGER NOT NULL,
                                          name            TEXT NOT NULL,
                                          model_year      INTEGER NOT NULL,
                                          engine_code     TEXT,
                                          displacement_l  REAL,
                                          base_hp         INTEGER NOT NULL,
                                          base_torque_nm  INTEGER NOT NULL,
                                          redline_rpm     INTEGER NOT NULL,
                                          UNIQUE (make_id, name, model_year),
    FOREIGN KEY (make_id) REFERENCES makes(id) ON DELETE CASCADE
    );

-- ==========================
-- Base ECU map per car model
-- ==========================
CREATE TABLE IF NOT EXISTS ecu_base_maps (
                                             id                  INTEGER PRIMARY KEY AUTOINCREMENT,
                                             car_model_id        INTEGER NOT NULL UNIQUE,
                                             afr                 REAL NOT NULL,
                                             ignition_timing_deg REAL NOT NULL,
                                             boost_psi           REAL NOT NULL,
                                             fuel_pressure_bar   REAL NOT NULL,
                                             rev_limit_rpm       INTEGER NOT NULL,
                                             intake_temp_c       REAL NOT NULL,
                                             coolant_temp_c      REAL NOT NULL,
                                             FOREIGN KEY (car_model_id) REFERENCES car_models(id) ON DELETE CASCADE
    );

-- ===================================
-- Rule engine for diagnostic detection
-- ===================================
CREATE TABLE IF NOT EXISTS diagnostic_rules (
                                                id                  INTEGER PRIMARY KEY AUTOINCREMENT,
                                                code                TEXT NOT NULL UNIQUE,
                                                parameter_key       TEXT NOT NULL,
                                                min_value           REAL,
                                                max_value           REAL,
                                                severity            TEXT NOT NULL CHECK (severity IN ('INFO', 'WARN', 'CRITICAL')),
    description         TEXT NOT NULL,
    fix_hint            TEXT NOT NULL
    );

-- ==========================
-- Presets and model-specific overrides
-- ==========================
CREATE TABLE IF NOT EXISTS presets (
                                       id              INTEGER PRIMARY KEY AUTOINCREMENT,
                                       name            TEXT NOT NULL UNIQUE,
                                       description     TEXT NOT NULL,
                                       is_randomized   INTEGER NOT NULL DEFAULT 0 CHECK (is_randomized IN (0, 1))
    );

CREATE TABLE IF NOT EXISTS preset_values (
                                             id                  INTEGER PRIMARY KEY AUTOINCREMENT,
                                             preset_id           INTEGER NOT NULL,
                                             car_model_id        INTEGER NOT NULL,
                                             afr_delta           REAL NOT NULL DEFAULT 0.0,
                                             timing_delta_deg    REAL NOT NULL DEFAULT 0.0,
                                             boost_delta_psi     REAL NOT NULL DEFAULT 0.0,
                                             fuel_press_delta    REAL NOT NULL DEFAULT 0.0,
                                             rev_limit_delta     INTEGER NOT NULL DEFAULT 0,
                                             UNIQUE (preset_id, car_model_id),
    FOREIGN KEY (preset_id) REFERENCES presets(id) ON DELETE CASCADE,
    FOREIGN KEY (car_model_id) REFERENCES car_models(id) ON DELETE CASCADE
    );

-- ==========================
-- Persist user tuning sessions
-- ==========================
CREATE TABLE IF NOT EXISTS tune_sessions (
                                             id                  INTEGER PRIMARY KEY AUTOINCREMENT,
                                             car_model_id        INTEGER NOT NULL,
                                             preset_id           INTEGER,
                                             final_map_json      TEXT NOT NULL,
                                             detected_codes_json TEXT NOT NULL,
                                             notes               TEXT,
                                             created_at          TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (car_model_id) REFERENCES car_models(id),
    FOREIGN KEY (preset_id) REFERENCES presets(id)
    );

-- Helpful indexes
CREATE INDEX IF NOT EXISTS idx_makes_manufacturer_id ON makes(manufacturer_id);
CREATE INDEX IF NOT EXISTS idx_models_make_id ON car_models(make_id);
CREATE INDEX IF NOT EXISTS idx_sessions_model_id ON tune_sessions(car_model_id);
CREATE INDEX IF NOT EXISTS idx_rules_parameter_key ON diagnostic_rules(parameter_key);