package br.AppReciclagem.appReciclagem.controller;

import br.AppReciclagem.appReciclagem.model.*;
import br.AppReciclagem.appReciclagem.repository.*;
import br.AppReciclagem.appReciclagem.service.*;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;



import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/admin")

public class AdminPageRestController {

    @Autowired
    private UsuarioService usuarioService;
    @Autowired private EntregaMaterialService entregaMaterialService;
    @Autowired private TrocaCestaService trocaCestaService;
    @Autowired private MaterialReciclavelService materialReciclavelService;
    @Autowired private UsuarioRepository usuarioRepository;
    @Autowired private CestaBasicaService cestaBasicaService;
    @Autowired private EntregaMaterialRepository entregaMaterialRepository;
    @Autowired private TrocaCestaRepository trocaCestaRepository;
    @Autowired private MaterialReciclavelRepository materialReciclavelRepository;
    @Autowired private CestaBasicaRepository cestaBasicaRepository;





    @PostMapping("/usuario/criar")
    @ResponseBody
    public ResponseEntity<Map<String, String>> criarUsuario(@ModelAttribute Usuario usuario) {
        String resp = usuarioService.validaUsuario(usuario, "cadastro");
        if(resp.equals("ok")){
            usuarioService.salvar(usuario);

            return ResponseEntity.ok(Map.of("status", "ok"));
        }

        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", resp));

    }

    @PostMapping("/usuario/editar")
    public ResponseEntity<Map<String, String>> editarUsuario(@ModelAttribute Usuario usuario) {
        String resp = usuarioService.validaUsuario(usuario, "alteracao");
        if(resp.equals("ok")){
            usuarioService.atualizarPorCpf(usuario.getCpf(), usuario);
            return ResponseEntity.ok(Map.of("status", "ok"));
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", resp));

    }

    @PostMapping("/usuario/excluir")
    public ResponseEntity<Map<String, String>> excluirUsuario(@RequestParam String cpfOuId) {
        String resp = usuarioService.validaExclusao(cpfOuId);
        if(resp.equals("ok")){
            usuarioService.excluirPorCpfOuId(cpfOuId);
            return ResponseEntity.ok(Map.of("status", "ok"));
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", resp));

    }

    @PostMapping("/usuario/entrega")
    public ResponseEntity<Map<String, String>> registrarEntrega(@ModelAttribute EntregaMaterial entrega) {
        String resp = entregaMaterialService.validaEntrega(entrega);
        if(resp.equals("ok")){
            entregaMaterialService.salvar(entrega);
            return ResponseEntity.ok(Map.of("status", "ok"));
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", resp));
    }
    @PostMapping("/material/cadastro")
    public ResponseEntity<Map<String, String>> cadastrarMaterial(@ModelAttribute MaterialReciclavel material){
        String resp = materialReciclavelService.validaCadastro(material);
        if(resp.equals("ok")){
            materialReciclavelRepository.save(material);
            return ResponseEntity.ok(Map.of("status", "ok"));
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", resp));
    }

    @GetMapping("/entregas/listar")
    public ResponseEntity<?> listarEntrega(){
        List<EntregaMaterial> entregas = entregaMaterialRepository.findAll();

        if(!entregas.isEmpty()){
            return ResponseEntity.ok(entregas);
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", "erro"));
    }

    @GetMapping("/materiais/listar")
    public ResponseEntity<?> listarMateriais(){
        List<MaterialReciclavel> materiais = materialReciclavelRepository.findAll();

        if(!materiais.isEmpty()){
            return ResponseEntity.ok(materiais);
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", "erro"));
    }

    @GetMapping("/cestas/listar")
    public ResponseEntity<?> listarCestas(){
        List<CestaBasica> cestas = cestaBasicaRepository.findAll();

        if(!cestas.isEmpty()){
            return ResponseEntity.ok(cestas);
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", "erro"));
    }
    @PostMapping("/cestas/atualizar")
    public ResponseEntity<Map<String, String>> atualizarCestas(@RequestParam String IdCestaBasica, @RequestParam(required = false) String qtdAdicionar){
        if(qtdAdicionar == null || qtdAdicionar.trim().isEmpty()){
            return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", "O campo quantidade não pode ser vazio"));
        }
        String resp = cestaBasicaService.validarAtualizacaoEstoque(qtdAdicionar);
        if(resp.equals("ok")){
            Long idCesta = Long.parseLong(String.valueOf(IdCestaBasica));
            Integer novoValor = Integer.parseInt(String.valueOf(qtdAdicionar));
            cestaBasicaService.atualizarPorId(idCesta, novoValor);
            return ResponseEntity.ok(Map.of("status", "ok"));
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", resp));
    }

    @PostMapping("/troca")
    public ResponseEntity<Map<String, String>> registrarTroca(TrocaCesta troca, Model model) {
        String resp = trocaCestaService.validaTroca(troca);
        if(resp.equals("ok")){

            return ResponseEntity.ok(Map.of("status", "ok"));
        }

        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", resp));
    }
    @GetMapping("/trocas/listar")
    public ResponseEntity<?> listarTroca(){
        List<TrocaCesta> trocas = trocaCestaRepository.findAll();
        if(!trocas.isEmpty()){
            return ResponseEntity.ok(trocas);
        }
        return ResponseEntity.badRequest().body(Map.of("status", "erro", "mensagem", "erro"));
    }

    @GetMapping("/usuario/buscar")
    @ResponseBody
    public ResponseEntity<Usuario> buscarUsuario(@RequestParam String chave) {
        Optional<Usuario> usuario;
        if(chave.equals("1")){
            return ResponseEntity.badRequest().build();
        }


        if (chave.matches("\\d{11}")) {
            usuario = usuarioRepository.findByCpf(chave);
        } else {
            try {
                Long id = Long.parseLong(chave);
                usuario = usuarioRepository.findById(id);
            } catch (NumberFormatException e) {
                return ResponseEntity.badRequest().build();
            }
        }

        return usuario.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }




}
