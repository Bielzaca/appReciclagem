package br.AppReciclagem.appReciclagem.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="cestabasica")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CestaBasica {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="IdCestaBasica")
    private short id;
    @Column(name="DescricaoCesta", nullable = false, length=50)
    private String descricaoCesta;
    @Column(name="ValorPorUnidade", nullable = false)
    private short valorPorUnidade;
    @Column(name="QtdEstoque", nullable = false)
    private int qtdEstoque;


}
