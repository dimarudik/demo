package com.example.demo.service;

import com.example.demo.model.Payment;
import com.example.demo.repository.PaymentRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;

@Service
public class PaymentService {
    private static final Logger logger = LogManager.getLogger(PaymentService.class);
    private final PaymentRepository paymentRepository;
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public PaymentService(PaymentRepository paymentRepository, JdbcTemplate jdbcTemplate) {
        this.paymentRepository = paymentRepository;
        this.jdbcTemplate = jdbcTemplate;
    }

    public Optional<Payment> findByUuid(UUID uuid) {
        logger.info(uuid + " version : " + uuid.version() + " variant : " + uuid.variant());
        return paymentRepository.findById(uuid);
    }

    public Optional<Payment> savePayment(Payment payment) {
        String shardingKey = payment.getClientId();
        setSessionShardId(shardingKey);
        return Optional.of(paymentRepository.save(payment));
    }

    public Optional<Payment> updateByUuid(UUID uuid, Payment payment) {
        if (!paymentRepository.existsById(uuid)) {
            return Optional.empty();
        }
        payment.setUuid(Objects.requireNonNull(paymentRepository
                .findById(uuid)
                .orElse(null)).getUuid());
        return Optional.of(paymentRepository.save(payment));
    }

    public boolean deleteByUuid(UUID uuid) {
        if (paymentRepository.existsById(uuid)) {
            paymentRepository.deleteById(uuid);
            return true;
        }
        return false;
    }

    public List<Payment> getAllPayments() {
        return paymentRepository.findAll();
    }

    public void setSessionShardId(String shardingKey) {
        jdbcTemplate.execute("SET SHARD TO " + getShardId(shardingKey));
    }

    public String getShardId(String shardingKey) {
        String[] strings = shardingKey.split("-");
        return String.valueOf(Long.parseLong(
                    (Long.valueOf(strings[0], 36).toString()
                    + Long.valueOf(strings[1], 36).toString())
                    ) % 2);
    }
}

