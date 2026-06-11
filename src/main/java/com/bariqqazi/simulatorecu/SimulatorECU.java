package com.bariqqazi.simulatorecu;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class SimulatorECU extends Application {

    private static Stage primaryStage;

    @Override
    public void start(Stage stage) throws Exception {
        primaryStage = stage;
        primaryStage.setTitle("SimulatorECU");
        showWelcomeScreen();
        primaryStage.show();
    }

    public static void showWelcomeScreen() throws Exception {
        FXMLLoader loader = new FXMLLoader(
                SimulatorECU.class.getResource("/com/bariqqazi/simulatorecu/welcome-view.fxml")
        );
        Scene scene = new Scene(loader.load(), 900, 600);
        primaryStage.setScene(scene);
    }

    public static void showVehicleSelectionScreen() throws Exception {
        FXMLLoader loader = new FXMLLoader(
                SimulatorECU.class.getResource("/com/bariqqazi/simulatorecu/vehicle-selection-view.fxml")
        );
        Scene scene = new Scene(loader.load(), 900, 600);
        primaryStage.setScene(scene);
    }

    public static void main(String[] args) {
        launch(args);
    }
}