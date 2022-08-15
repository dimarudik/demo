package com.example.demo.model;

import lombok.Data;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "payments_tab")
@Data
public class Payment {
    @Id
    @GeneratedValue
    @Type(type = "uuid-char")
    private UUID uuid;
    private LocalDateTime timestamp;
    private String clientId;
    private BigDecimal amount;
    @Column(length = 4)
    private String status;
}
