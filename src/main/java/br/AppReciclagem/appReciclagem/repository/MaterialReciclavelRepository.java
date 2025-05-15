package br.AppReciclagem.appReciclagem.repository;

import br.AppReciclagem.appReciclagem.model.MaterialReciclavel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MaterialReciclavelRepository extends JpaRepository<MaterialReciclavel, Short> {
}
