package br.AppReciclagem.appReciclagem.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name="trocacesta")
@Data
@NoArgsConstructor
@AllArgsConstructor

public class TrocaCesta {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="IdTroca")
    private Long id;

    @Column(name="IdCestaBasica", nullable = false)
    private short idCesta;
    @Column(name="QtdTroca", nullable = false)
    private short qtdTroca;

    @Column(name="ValorGeradoTroca", nullable = false)
    private int valorGeradoTroca;

    @Column(name="DataTroca", nullable = false)
    private LocalDate dataTroca;

    @Column(name="IdUsuario", nullable = false)
    private Long idUsuario;

}
