package br.AppReciclagem.appReciclagem.repository;

import br.AppReciclagem.appReciclagem.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface UsuarioRepository extends JpaRepository<Usuario, Long > {
    Usuario findByUsuarioLoginAndUsuarioSenha(String usuarioLogin, String usuarioSenha);
    Optional<Usuario> findByCpf(String cpf);

    Optional<Usuario> findByUsuarioLogin(String usuarioLogin);

    @Query(value="SELECT u FROM Usuario u WHERE u.usuarioLogin = :UsuarioLogin AND u.usuarioSenha = :UsuarioSenha")
    public Usuario login(@Param("UsuarioLogin") String UsuarioLogin, @Param("UsuarioSenha") String UsuarioSenha);

}
