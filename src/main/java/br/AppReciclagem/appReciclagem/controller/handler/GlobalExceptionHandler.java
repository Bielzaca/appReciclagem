package br.AppReciclagem.appReciclagem.controller.handler;

import org.hibernate.TypeMismatchException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleTypeMismatch(MethodArgumentNotValidException ex) {
        return ResponseEntity.badRequest().body(Map.of("mensagem", "Por favor digite um número inteiro na quantidade"));
    }

    @ExceptionHandler(TypeMismatchException.class)
    public ResponseEntity<String> handleTypeMismatch(TypeMismatchException ex) {
        return ResponseEntity.badRequest().body("Erro de tipo: " + ex.getMessage());
    }
}
