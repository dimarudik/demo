package com.example.demo.controller;

import com.example.demo.model.Payment;
import com.example.demo.service.PaymentService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;
import java.util.UUID;

@RestController
public class Controller {
    private final PaymentService paymentService;
    private static final Logger logger = LogManager.getLogger(Controller.class);

    @Autowired
    public Controller(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping("/payment")
    public ResponseEntity<Payment> newPayment(@RequestBody Payment payment) {
        return ResponseEntity.ok(
                paymentService
                        .savePayment(payment)
                        .orElseThrow(() -> new ResponseStatusException(
                                HttpStatus.BAD_REQUEST, "Payment can not be saved"
                        )));
    }

    @RequestMapping(value = "/payment/{uuid}", method = RequestMethod.GET)
    public ResponseEntity<Payment> findByUuid(@PathVariable("uuid") String uuid) {
        return ResponseEntity.ok(
                paymentService
                        .findByUuid(UUID.fromString(uuid))
                        .orElseThrow(() -> new ResponseStatusException(
                                HttpStatus.BAD_REQUEST, "No payment with specified ID was found"
                        )));
    }

    @RequestMapping(value = "/payment/{uuid}", method = RequestMethod.POST)
    public ResponseEntity<Payment> updateByUuid(@PathVariable("uuid") String uuid, @RequestBody Payment payment) {
        return ResponseEntity.ok(
                paymentService
                        .updateByUuid(UUID.fromString(uuid), payment)
                        .orElseThrow(() -> new ResponseStatusException(
                                HttpStatus.BAD_REQUEST, "No payment with specified ID was found"
                        )));
    }

    @GetMapping("/payments")
    public ResponseEntity<List<Payment>> getAllPayments() {
        return ResponseEntity.ok(paymentService.getAllPayments());
    }

    @GetMapping("/hostname")
    public ResponseEntity<String> getHostname() {
        try {
            return ResponseEntity.ok(InetAddress.getLocalHost().getHostName());
        } catch (UnknownHostException e) {
            logger.error(e.getMessage());
            return null;
        }
    }
}
