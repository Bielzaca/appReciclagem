package br.AppReciclagem.appReciclagem.service;

import br.AppReciclagem.appReciclagem.model.Usuario;
import br.AppReciclagem.appReciclagem.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.regex.Pattern;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public Usuario buscarPorId(Long id) {
        return usuarioRepository.findById(id).orElse(null);
    }

    public Page<Usuario> listarTodos(Pageable pageable) {
        return usuarioRepository.findAll(pageable);
    }

    public Usuario login(String login, String senha) {
        return usuarioRepository.findByUsuarioLoginAndUsuarioSenha(login, senha);
    }
    public void salvar(Usuario usuario) {
        usuarioRepository.save(usuario);
    }

    public void atualizarPorCpf(String cpf, Usuario novosDados) {
        Optional<Usuario> user = usuarioRepository.findByCpf(cpf);
        user.ifPresent(usuario -> {
            usuario.setNome(novosDados.getNome());
            usuario.setTelefone(novosDados.getTelefone());
            usuario.setEndereco(novosDados.getEndereco());
            usuario.setSaldoCreditos(novosDados.getSaldoCreditos());
            usuarioRepository.save(usuario);
        });
    }

    public void excluirPorCpfOuId(String valor) {
        try {
            Long id = Long.parseLong(valor);
            usuarioRepository.deleteById(id);
        } catch (NumberFormatException e) {
            usuarioRepository.findByCpf(valor).ifPresent(usuarioRepository::delete);
        }
    }

    public String validaUsuario(Usuario userData, String tipoOperacao){
       if (userData.getNome().isBlank() || userData.getNome().length() < 3){
           return "O campo nome deve conter no mínimo 3 caracteres";
       }
        Pattern patternCPF = Pattern.compile("^\\d{11}$");
        //System.out.println(patternCPF.matcher(userData.getCpf()).matches() + " linha 59 usuarioservice"); // true

       if(!patternCPF.matcher(userData.getCpf()).matches()){

           return "O campo CPF deve conter apenas digitos e 11 números";
       }
       if(tipoOperacao.equals("cadastro")){
           if(usuarioRepository.findByCpf(userData.getCpf()).isPresent()){
               return "Já existe um usuário cadastrado com o CPF informado";
           }
       }

       Pattern patternTelefone = Pattern.compile("^[^\\d]*(\\d[^\\d]*){10,}$");
       //boolean teste = patternTelefone.matcher("(11) 91234-5678").matches();
        //System.out.println(teste + "boolean linha 65 ");
        //System.out.println(userData.getTelefone() + "telefone ");
        //System.out.println(patternTelefone.matcher(userData.getTelefone()).matches() + "linha 64 usuarioservice");
       if(!patternTelefone.matcher(userData.getTelefone()).matches()){
           return "O campo telefone deve conter apenas números (10 digitos sem contar caracteres especiais)";
       }
       if(userData.getEndereco().isBlank() || userData.getEndereco().length() < 6 ){
           return "Por favor preencha um endereço válido";
       }
       if(userData.getUsuarioLogin().isBlank() || userData.getUsuarioLogin().length() < 4){
           return "Por favor insira um nome de login válido (minimo 4 caracteres)";
       }
        if(tipoOperacao == "cadastro"){
            if(usuarioRepository.findByUsuarioLogin(userData.getUsuarioLogin()).isPresent()){
                return "Já existe um usuário com o login informado`";
            }
        }

       if(userData.getUsuarioSenha().length() < 8){
           return "A senha deve conter ao menos 8 caracteres";
       }

       return "ok";
    }
    public String validaExclusao (String cpfOuId){
        if(cpfOuId.trim().equals("1")){
            return "Não é possível excluir o usuário administrador";
        }
        if(usuarioRepository.findByCpf(cpfOuId).isEmpty()){
            if(usuarioRepository.findById(Long.parseLong(String.valueOf(cpfOuId))).isEmpty()){
                return "Usuário não encontrado";
            }
        }
        return "ok";
    }
}
