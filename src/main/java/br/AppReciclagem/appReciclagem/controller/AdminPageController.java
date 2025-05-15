package br.AppReciclagem.appReciclagem.controller;

import br.AppReciclagem.appReciclagem.model.Usuario;
import br.AppReciclagem.appReciclagem.repository.MaterialReciclavelRepository;
import br.AppReciclagem.appReciclagem.service.CestaBasicaService;
import br.AppReciclagem.appReciclagem.service.MaterialReciclavelService;
import br.AppReciclagem.appReciclagem.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AdminPageController {
    @Autowired
    private UsuarioService usuarioService;
    @Autowired private MaterialReciclavelService materialReciclavelService;
    @Autowired private CestaBasicaService cestaBasicaService;
    @Autowired private MaterialReciclavelRepository materialReciclavelRepository;

    @GetMapping
    public String adminHome(Model model, @RequestParam(defaultValue = "0") int page) {

        Page<Usuario> usuarios = usuarioService.listarTodos(PageRequest.of(page, 10));
        model.addAttribute("usuarios", usuarios);
        model.addAttribute("materiais", materialReciclavelService.buscarTodos());
        model.addAttribute("cestas", cestaBasicaService.buscarTodos());






        return "admin";
    }
}
