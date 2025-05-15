package br.AppReciclagem.appReciclagem.repository;

import br.AppReciclagem.appReciclagem.model.CestaBasica;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CestaBasicaRepository extends JpaRepository<CestaBasica, Long> {


}
