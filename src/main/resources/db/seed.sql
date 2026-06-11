PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

-- ==================
-- Manufacturers
-- ==================
INSERT OR IGNORE INTO manufacturers (id, name, logo_path) VALUES
(1, 'Toyota', 'assets/logos/manufacturers/toyota.png'),
(2, 'BMW',    'assets/logos/manufacturers/bmw.png'),
(3, 'Ford',   'assets/logos/manufacturers/ford.png');

-- ==================
-- Makes
-- ==================
INSERT OR IGNORE INTO makes (id, manufacturer_id, name, logo_path) VALUES
(1, 1, 'GR',           'assets/logos/makes/gr.png'),
(2, 1, 'Toyota Core',  'assets/logos/makes/toyota_core.png'),
(3, 2, 'M Performance','assets/logos/makes/m_performance.png'),
(4, 2, 'BMW Core',     'assets/logos/makes/bmw_core.png'),
(5, 3, 'Ford Performance', 'assets/logos/makes/ford_performance.png'),
(6, 3, 'Ford Core',    'assets/logos/makes/ford_core.png');

-- ==================
-- Car Models (6)
-- ==================
INSERT OR IGNORE INTO car_models
(id, make_id, name, model_year, engine_code, displacement_l, base_hp, base_torque_nm, redline_rpm) VALUES
(1, 1, 'GR Supra 3.0',        2021, 'B58',     3.0, 382, 500, 7000),
(2, 2, 'Corolla 2.0',         2020, 'M20A',    2.0, 169, 205, 6700),
(3, 3, 'M340i xDrive',        2021, 'B58TU',   3.0, 382, 500, 7000),
(4, 4, '330i',                2020, 'B48',     2.0, 255, 400, 6800),
(5, 5, 'Mustang GT',          2021, 'Coyote',  5.0, 450, 556, 7500),
(6, 6, 'Focus ST',            2018, 'EcoBoost',2.0, 252, 366, 6800);

-- ==================
-- Base ECU Maps
-- ==================
INSERT OR IGNORE INTO ecu_base_maps
(car_model_id, afr, ignition_timing_deg, boost_psi, fuel_pressure_bar, rev_limit_rpm, intake_temp_c, coolant_temp_c) VALUES
(1, 14.7, 12.0, 11.5, 3.8, 7000, 30.0, 92.0),
(2, 14.7, 10.0,  0.0, 3.5, 6700, 28.0, 90.0),
(3, 14.7, 12.0, 12.0, 3.9, 7000, 29.0, 92.0),
(4, 14.7, 11.0, 10.0, 3.7, 6800, 30.0, 91.0),
(5, 14.1, 14.0,  0.0, 4.0, 7500, 32.0, 94.0),
(6, 14.7, 11.0, 15.0, 3.8, 6800, 31.0, 93.0);

-- ==================
-- Diagnostic Rules (8)
-- ==================
INSERT OR IGNORE INTO diagnostic_rules
(code, parameter_key, min_value, max_value, severity, description, fix_hint) VALUES
('P0171', 'afr',                 NULL, 16.0, 'CRITICAL', 'System too lean (high AFR).', 'Increase fuel delivery; reduce airflow/boost; check intake leaks.'),
('P0172', 'afr',                 11.5, NULL, 'CRITICAL', 'System too rich (low AFR).', 'Reduce fuel delivery; verify injector scaling and sensor calibration.'),
('P0234', 'boost_psi',           NULL, 18.0, 'CRITICAL', 'Engine overboost condition.', 'Lower boost target; inspect wastegate/boost control hardware.'),
('P0101', 'fuel_pressure_bar',   3.0, 5.0,   'WARN',     'Fuel pressure out of expected range.', 'Check fuel pump/regulator; return pressure to safe range.'),
('P0219', 'rev_limit_rpm',       NULL, 7600, 'WARN',     'Engine overspeed risk.', 'Reduce rev limiter and shift earlier.'),
('P0113', 'intake_temp_c',       NULL, 70.0, 'WARN',     'Intake air temperature too high.', 'Improve cooling/intercooling and reduce sustained load.'),
('P0128', 'coolant_temp_c',      75.0, 105.0,'WARN',     'Coolant temperature outside normal operating range.', 'Verify thermostat/cooling system and fan operation.'),
('KNOCK1','ignition_timing_deg', NULL, 18.0, 'CRITICAL', 'Ignition timing too advanced for safe operation.', 'Retard timing and/or lower boost; use higher-octane fuel.');

-- ==================
-- Presets
-- ==================
INSERT OR IGNORE INTO presets (id, name, description, is_randomized) VALUES
(1, 'Fuel Efficient', 'Conservative tune focused on economy and reliability.', 0),
(2, 'Max Power',      'Aggressive tune targeting maximum horsepower/torque.', 0),
(3, 'Balanced',       'Optimal compromise of power, efficiency, and reliability.', 0),
(4, 'Random Faulted', 'Inject randomized out-of-range parameters for diagnostics training.', 1);

-- ==================
-- Preset Values per Model
-- ==================
-- Fuel Efficient
INSERT OR IGNORE INTO preset_values
(preset_id, car_model_id, afr_delta, timing_delta_deg, boost_delta_psi, fuel_press_delta, rev_limit_delta) VALUES
(1,1, +0.4, -1.0, -2.0, -0.1, -200),
(1,2, +0.3, -0.5,  0.0, -0.1, -150),
(1,3, +0.4, -1.0, -2.0, -0.1, -200),
(1,4, +0.3, -0.5, -1.5, -0.1, -150),
(1,5, +0.2, -1.5,  0.0, -0.1, -250),
(1,6, +0.3, -0.7, -2.0, -0.1, -180);

-- Max Power
INSERT OR IGNORE INTO preset_values
(preset_id, car_model_id, afr_delta, timing_delta_deg, boost_delta_psi, fuel_press_delta, rev_limit_delta) VALUES
(2,1, -0.8, +2.0, +3.0, +0.3, +200),
(2,2, -0.5, +1.0, +0.0, +0.2, +100),
(2,3, -0.8, +2.0, +3.0, +0.3, +200),
(2,4, -0.7, +1.5, +2.0, +0.2, +150),
(2,5, -0.6, +2.0, +0.0, +0.2, +200),
(2,6, -0.8, +1.5, +3.0, +0.3, +150);

-- Balanced
INSERT OR IGNORE INTO preset_values
(preset_id, car_model_id, afr_delta, timing_delta_deg, boost_delta_psi, fuel_press_delta, rev_limit_delta) VALUES
(3,1, -0.3, +0.8, +1.0, +0.1, +100),
(3,2, -0.2, +0.4, +0.0, +0.1,  +80),
(3,3, -0.3, +0.8, +1.0, +0.1, +100),
(3,4, -0.3, +0.6, +0.8, +0.1,  +90),
(3,5, -0.2, +0.8, +0.0, +0.1, +120),
(3,6, -0.3, +0.7, +1.0, +0.1, +100);

COMMIT;