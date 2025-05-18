document.addEventListener("DOMContentLoaded", function() {

    const confirmacaoModal = new bootstrap.Modal(document.getElementById('confirmacaoExclusaoModal'));


    const btnExcluirUsuario = document.getElementById('btnExcluirUsuario');
    if (btnExcluirUsuario) {
        btnExcluirUsuario.addEventListener('click', function() {
            confirmacaoModal.show();
        });
    }

    // Botão de confirmação dentro do modal
    const confirmarExclusaoBtn = document.getElementById('confirmarExclusaoUsuario');
    if (confirmarExclusaoBtn) {
        confirmarExclusaoBtn.addEventListener('click', function() {
            excluirUsuario();

            confirmacaoModal.hide();
        });
    }

    // Restante do seu script existente...
});

function excluirUsuario(){




             const formExcluirUsuario = document.getElementById("formExcluir");
             const formData = new FormData(formExcluirUsuario);

             fetch("/admin/usuario/excluir", {
                 method: "POST",
                 body: new URLSearchParams(formData)
             })
             .then(response => response.json())
             .then(data => {

                 const mensagemDiv = document.getElementById("mensagemExcluir");
                 console.log(mensagemDiv);
                 if (data.status === "ok") {
                     mensagemDiv.innerHTML = "<div class='alert alert-success'>Usuário excluido com sucesso!</div>";
                     formExcluirUsuario.reset();
                     mensagemDiv.hidden = false;
                 } else {
                     mensagemDiv.innerHTML = `<div class='alert alert-danger'>${data.mensagem}</div>`;
                     mensagemDiv.hidden = false;
                 }
                 mensagemDiv.scrollIntoView({ behavior: 'smooth' });
             })
             .catch(error => {
                 console.error("Erro ao excluir:", error);
             });

}

