package com.example.backend.Projection;

import org.springframework.beans.factory.annotation.Value;

import java.time.LocalDate;
import java.time.ZoneId;

public interface DashboardProjection {
    @Value("#{target.support_phone}")
    String getSupportPhone();

    @Value("#{T(java.time.LocalDate).ofInstant(target.current_date_and_time, T(java.time.ZoneId).systemDefault())}")
    LocalDate getCurrentDateAndTime();
}
