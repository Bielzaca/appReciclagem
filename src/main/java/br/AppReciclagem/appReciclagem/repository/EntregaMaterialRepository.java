package br.AppReciclagem.appReciclagem.repository;

import br.AppReciclagem.appReciclagem.model.EntregaMaterial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EntregaMaterialRepository extends JpaRepository<EntregaMaterial, Long> {
    List<EntregaMaterial> findByIdUsuario(Long idUsuario);

    @Query("SELECT e FROM EntregaMaterial e JOIN FETCH e.material WHERE e.idUsuario = :idUsuario")
    List<EntregaMaterial> buscarComMaterialPorUsuario(@Param("idUsuario") Long idUsuario);
}
