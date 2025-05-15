package br.AppReciclagem.appReciclagem.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="materialreciclavel")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MaterialReciclavel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="IdMaterial")
    private short id;

    @Column(name="TipoMaterial", nullable = false, length=50)
    private String tipoMaterial;

    @Column(name="ValorPorPeso", nullable = false)
    private int valorPorPeso;

    @Column(name="QtdEstoqueKG", nullable = false)
    private int qtdEstoqueKG;
}
