package com.bariqqazi.simulatorecu;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;

import java.util.List;
import java.util.Map;

public class VehicleSelectionController {

    @FXML private ComboBox<String> manufacturerCombo;
    @FXML private ComboBox<String> makeCombo;
    @FXML private ComboBox<String> modelCombo;
    @FXML private Label selectedCarLabel;
    @FXML private Label statusLabel;

    private final Map<String, Map<String, List<String>>> data = Map.of(
            "Toyota", Map.of(
                    "GR", List.of("GR Supra 3.0"),
                    "Core", List.of("Corolla 2.0")
            ),
            "BMW", Map.of(
                    "M Performance", List.of("M340i xDrive"),
                    "Core", List.of("330i")
            ),
            "Ford", Map.of(
                    "Performance", List.of("Mustang GT"),
                    "Core", List.of("Focus ST")
            )
    );

    @FXML
    public void initialize() {
        manufacturerCombo.setItems(FXCollections.observableArrayList(data.keySet()));
        statusLabel.setText("Choose manufacturer, make, and model.");
    }

    @FXML
    private void onManufacturerChanged() {
        String manufacturer = manufacturerCombo.getValue();
        makeCombo.getItems().clear();
        modelCombo.getItems().clear();
        selectedCarLabel.setText("Selected Car: -");

        if (manufacturer != null) {
            makeCombo.setItems(FXCollections.observableArrayList(data.get(manufacturer).keySet()));
        }
    }

    @FXML
    private void onMakeChanged() {
        String manufacturer = manufacturerCombo.getValue();
        String make = makeCombo.getValue();
        modelCombo.getItems().clear();
        selectedCarLabel.setText("Selected Car: -");

        if (manufacturer != null && make != null) {
            modelCombo.setItems(FXCollections.observableArrayList(data.get(manufacturer).get(make)));
        }
    }

    @FXML
    private void onModelChanged() {
        String manufacturer = manufacturerCombo.getValue();
        String make = makeCombo.getValue();
        String model = modelCombo.getValue();

        if (manufacturer != null && make != null && model != null) {
            selectedCarLabel.setText("Selected Car: " + manufacturer + " / " + make + " / " + model);
            statusLabel.setText("Ready. Click Next to continue.");
        }
    }

    @FXML
    private void onNextClick() {
        String model = modelCombo.getValue();
        if (model == null) {
            statusLabel.setText("Please select a model before continuing.");
            return;
        }

        statusLabel.setText("Next screen placeholder: Diagnostics/Tuning coming next.");
    }

    @FXML
    private void onBackClick() {
        try {
            SimulatorECU.showWelcomeScreen();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
