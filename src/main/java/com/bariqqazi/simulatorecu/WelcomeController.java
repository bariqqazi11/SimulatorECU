package com.bariqqazi.simulatorecu;

import javafx.fxml.FXML;

public class WelcomeController {

    @FXML
    private void onStartClick() {
        try {
            SimulatorECU.showVehicleSelectionScreen();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}