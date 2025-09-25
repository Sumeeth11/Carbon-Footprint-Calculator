package com.example.carboncalc;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpSession;


@WebServlet(name = "calculateServlet", value = "/calculate")
public class CalculateServlet extends HttpServlet {

    private double round2(double v) {
        return Math.round(v * 100.0) / 100.0;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        try {
            // --- 1. Read and validate inputs ---
            String sElectricity = request.getParameter("electricity");
            String sFuel = request.getParameter("fuel");
            String sDistance = request.getParameter("distance");
            String sWaste = request.getParameter("waste");
            String sWater = request.getParameter("water");

            if (sElectricity == null || sElectricity.isBlank()
                    || sFuel == null || sFuel.isBlank()
                    || sDistance == null || sDistance.isBlank()) {
                throw new IllegalArgumentException("Please fill all fields.");
            }

            double electricity = Double.parseDouble(sElectricity);
            double fuel = Double.parseDouble(sFuel);
            double distance = Double.parseDouble(sDistance);
            double waste = Double.parseDouble(sWaste);
            double water = Double.parseDouble(sWater);

            if (electricity < 0 || fuel < 0 || distance < 0) {
                throw new IllegalArgumentException("Values cannot be negative.");
            }

            // --- 2. Emission factors ---
            double electricityFactor = 0.85; // kg CO2 per kWh
            double fuelFactor = 2.31;        // kg CO2 per liter
            double distanceFactor = 0.12;    // kg CO2 per km
            double wasteFactor = 2.5;   // kg CO2 per kg waste
            double waterFactor = 0.001;

            // --- 3. Calculate emissions ---
            double electricityEmissions = electricity * electricityFactor;
            double fuelEmissions = fuel * fuelFactor;
            double distanceEmissions = distance * distanceFactor;
            double wasteEmissions = waste * wasteFactor;
            double waterEmissions = water * waterFactor;
            double totalFootprint = electricityEmissions + fuelEmissions + distanceEmissions
                    + wasteEmissions + waterEmissions;

            // Round values to 2 decimals for display and consistency
            electricityEmissions = round2(electricityEmissions);
            fuelEmissions = round2(fuelEmissions);
            distanceEmissions = round2(distanceEmissions);
            wasteEmissions = round2(wasteEmissions);
            waterEmissions = round2(waterEmissions);
            totalFootprint = round2(totalFootprint);


            // --- 4. Comparison with average and progress color ---
            double averageFootprint = 300.0; // put this BEFORE use
            String comparisonMessage;
            double epsilon = 0.5; // tolerance for "equal" (since doubles)
            if (Math.abs(totalFootprint - averageFootprint) < epsilon) {
                comparisonMessage = "⚖️ Your footprint is about the average (" + averageFootprint + " kg CO₂).";
            } else if (totalFootprint < averageFootprint) {
                comparisonMessage = "✅ Good job! Your footprint is below the average of " + averageFootprint + " kg CO₂.";
            } else {
                comparisonMessage = "⚠️ Your footprint is above the average of " + averageFootprint + " kg CO₂. Try reducing it.";
            }

            // decide color: green / yellow / red
            String progressColor;
            if (totalFootprint < averageFootprint) {
                progressColor = "#2ecc71"; // green
            } else if (Math.abs(totalFootprint - averageFootprint) < epsilon) {
                progressColor = "#f1c40f"; // yellow
            } else {
                progressColor = "#e74c3c"; // red
            }

            // --- 5. Set attributes for JSP (use numeric Double for charts/arithmetic) ---
            request.setAttribute("electricityEmissions", electricityEmissions);
            request.setAttribute("fuelEmissions", fuelEmissions);
            request.setAttribute("distanceEmissions", distanceEmissions);
            request.setAttribute("wasteEmissions", wasteEmissions);
            request.setAttribute("waterEmissions", waterEmissions);
            request.setAttribute("totalFootprint", totalFootprint);

            request.setAttribute("comparisonMessage", comparisonMessage);
            request.setAttribute("progressColor", progressColor);

            // --- 6. Save results to history table ---
            try (Connection conn = DBUtil.getConnection()) {
                HttpSession session = request.getSession();
                Integer userId = (Integer) session.getAttribute("userId");  // from LoginServlet

                if (userId != null) {
                    String sql = "INSERT INTO history (user_id, electricity, fuel, distance, waste, water, total) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, userId);
                    ps.setDouble(2, electricityEmissions);
                    ps.setDouble(3, fuelEmissions);
                    ps.setDouble(4, distanceEmissions);
                    ps.setDouble(5, wasteEmissions);
                    ps.setDouble(6, waterEmissions);
                    ps.setDouble(7, totalFootprint);
                    ps.executeUpdate();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }



            // Forward to JSP
            request.getRequestDispatcher("result.jsp").forward(request, response);

        } catch (NumberFormatException nfe) {
            request.setAttribute("errorMessage", "Invalid number format. Please enter valid numeric values.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (IllegalArgumentException iae) {
            request.setAttribute("errorMessage", iae.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            // generic fallback
            request.setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
