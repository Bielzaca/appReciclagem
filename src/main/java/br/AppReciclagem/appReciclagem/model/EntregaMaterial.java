package br.AppReciclagem.appReciclagem.model;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@Table(name = "entregamaterial")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class EntregaMaterial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="IdEntrega")
    private Long id;

    @Column(name="IdMaterial", nullable = false)
    private Long idMaterial;

    @Column(name="QtdEntregaKG", nullable = false)
    private int qtdEntregaKG;

    @Column(name="ValorGeradoEntrega", nullable = false)
    private int valorGeradoEntrega;

    @Column(name="DataEntrega", nullable = false)
    private LocalDate dataEntrega;


    @Column(name="IdUsuario", nullable = false)
    private Long idUsuario;

    @ManyToOne
    @JoinColumn(name = "IdMaterial", referencedColumnName = "IdMaterial", insertable = false, updatable = false)
    private MaterialReciclavel material;
}
