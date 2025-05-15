package br.AppReciclagem.appReciclagem.controller;

import br.AppReciclagem.appReciclagem.model.EntregaMaterial;
import br.AppReciclagem.appReciclagem.model.TrocaCesta;
import br.AppReciclagem.appReciclagem.model.Usuario;
import br.AppReciclagem.appReciclagem.service.CookieService;
import br.AppReciclagem.appReciclagem.service.EntregaMaterialService;
import br.AppReciclagem.appReciclagem.service.TrocaCestaService;
import br.AppReciclagem.appReciclagem.service.UsuarioService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
public class UsuarioController {
    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private TrocaCestaService trocaCestaService;

    @Autowired
    private EntregaMaterialService entregaMaterialService;

    @GetMapping("/usuario")
    public String paginaAdmin(Model model, HttpServletRequest request) throws UnsupportedEncodingException {


        Long idUsuario = Long.valueOf(CookieService.getCookie(request, "usuarioId"));

        Usuario usuario = usuarioService.buscarPorId(idUsuario);
        List<TrocaCesta> trocas = trocaCestaService.buscarPorUsuario(idUsuario);
        List<EntregaMaterial> entregas = entregaMaterialService.buscarPorUsuario(idUsuario);

        model.addAttribute("usuario", usuario);
        model.addAttribute("trocas", trocas);
        model.addAttribute("entregas", entregas);

        return "usuario";
    }

}
