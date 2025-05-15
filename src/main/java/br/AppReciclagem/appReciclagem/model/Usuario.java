package br.AppReciclagem.appReciclagem.model;

import jakarta.persistence.*;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "usuario")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "\"IdUsuario\"")
    private Long id;

    @Column(name = "Nome", nullable = false, length = 50)
    private String nome;

    @Column(name = "Cpf", nullable = false, length = 11)
    private String cpf;

    @Column(name = "Telefone", nullable = false, length = 15)
    private String telefone;

    @Column(name = "Endereco", nullable = false, columnDefinition = "TEXT")
    private String endereco;

    @Column(name = "UsuarioLogin", nullable = false, length = 20)
    private String usuarioLogin;

    @Column(name = "UsuarioSenha", nullable = false, length = 45)
    private String usuarioSenha;

    @Column(name = "SaldoCreditos", nullable = false)
    private int saldoCreditos;


}
