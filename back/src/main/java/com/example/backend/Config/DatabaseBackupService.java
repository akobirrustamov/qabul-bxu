//package com.example.backend.Config;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Service;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.time.LocalDateTime;
//@Service
//public class
//DatabaseBackupService {
//    private static final Logger logger = LoggerFactory.getLogger(DatabaseBackupService.class);
//    private final String dbName = "postgres"; // Your database name
//    private final String user = "postgres"; // Your username
//    private final String password = "akow8434"; // Your password
//    private final String backupDir = "./"; // Directory to save backups
//    @Scheduled(fixedRate = 86400000) // 8 seconds for testing; change to 86400000 (24 hours) for production
//    public void backupDatabase() {
//        String timestamp = LocalDateTime.now().toString().replace(":", "-");
//        String backupFilePath = backupDir + "backup_" + timestamp + ".sql";
//        String[] command = {
//                "pg_dump",
//                "-U", user,
//                "-d", dbName,
//                "-p", "5433",
//                "-f", backupFilePath,
//                "--no-password"
//        };
//        ProcessBuilder processBuilder = new ProcessBuilder(command);
//        processBuilder.environment().put("PGPASSWORD", password); // Set the password in the environment
//        try {
//            Process process = processBuilder.start();
//            // Capture output and error streams
//            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
//            BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
//            String line;
//            // Log standard output
//            while ((line = reader.readLine()) != null) {
//                logger.info(line);
//            }
//            // Log error output
//            while ((line = errorReader.readLine()) != null) {
//                logger.error(line);
//            }
//            int exitCode = process.waitFor();
//            if (exitCode == 0) {
//                logger.info("Database backup completed successfully at {}", backupFilePath);
//            } else {
//                logger.error("Database backup failed with exit code: {}", exitCode);
//            }
//        } catch (IOException | InterruptedException e) {
//            logger.error("Error occurred while backing up the database: {}", e.getMessage(), e);
//        }
//    }
//}