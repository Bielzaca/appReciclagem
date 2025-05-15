
    document.addEventListener("DOMContentLoaded", () => {
        const abaUsuarios = document.getElementById("usuarios-tab");

        abaUsuarios.addEventListener("click", () => {
            window.location.reload();
        });
    });


    function buscarUsuario() {
        const chave = document.getElementById("chaveBusca").value;
        let mensagemAtualizar = document.getElementById("mensagemAtualizar");
        let form = document.getElementById("formAlterarUsuario");
        mensagemAtualizar.hidden = true;

        if (!chave) {
            mensagemAtualizar.innerHTML = "<div class='alert alert-danger'>Por favor, digite um ID ou CPF</div>";;
                            mensagemAtualizar.hidden = false;
                            form.reset();
            return;
        }
        if(chave.trim() == "1"){
        mensagemAtualizar.innerHTML = "<div class='alert alert-danger'>Não é possível alterar os dados do usuário administrador</div>";
                                    mensagemAtualizar.hidden = false;
                                    form.reset();
                    return;
        }

        fetch(`/admin/usuario/buscar?chave=${encodeURIComponent(chave)}`)
            .then(response => {
                if (!response.ok) {
                    mensagemAtualizar.innerHTML = "<div class='alert alert-danger'>Usuário não encontrado</div>";
                    mensagemAtualizar.hidden = false;
                    form.reset();
                }
                return response.json();
            })
            .then(data => {
                document.getElementById("id").value = data.id;
                document.getElementById("nome").value = data.nome;
                document.getElementById("cpf").value = data.cpf;
                document.getElementById("telefone").value = data.telefone;
                document.getElementById("endereco").value = data.endereco;
                document.getElementById("usuarioLogin").value = data.usuarioLogin;
                document.getElementById("usuarioSenha").value = data.usuarioSenha;
                document.getElementById("saldoCreditos").value = data.saldoCreditos;

                let formAlterar = document.getElementById("formAlterarUsuario");
                formAlterar.hidden = false;
                formAlterar.scrollIntoView({ behavior: 'smooth' });
            })
            .catch(error => {

            });
    }

    document.getElementById("formCadastro").addEventListener("submit", function(e) {
        e.preventDefault();

        const form = e.target;
        const formData = new FormData(form);

        fetch("/admin/usuario/criar", {
            method: "POST",
            body: new URLSearchParams(formData)
        })
        .then(response => response.json())
        .then(data => {
            const mensagemDiv = document.getElementById("mensagemCadastro");
            if (data.status === "ok") {
                mensagemDiv.innerHTML = "<div class='alert alert-success'>Usuário cadastrado com sucesso!</div>";
                form.reset();
            } else {
                mensagemDiv.innerHTML = `<div class='alert alert-danger'>${data.mensagem}</div>`;
            }
            mensagemDiv.scrollIntoView({ behavior: 'smooth' });
        })
        .catch(error => {
            console.error("Erro ao cadastrar:", error);
        });
    });

    document.getElementById("formAlterarUsuario").addEventListener("submit", function(e) {
        e.preventDefault();

        const form = e.target;
        const formData = new FormData(form);

        fetch("/admin/usuario/editar", {
            method: "POST",
            body: new URLSearchParams(formData)
        })
        .then(response => response.json())
        .then(data => {
            const mensagemDiv = document.getElementById("mensagemAtualizar");
            if (data.status === "ok") {
                mensagemDiv.innerHTML = "<div class='alert alert-success'>Usuário alterado com sucesso!</div>";
                mensagemDiv.hidden = false;
                form.reset();
                let formAlterar = document.getElementById("formAlterarUsuario");
                formAlterar.hidden = true;
            } else {
                mensagemDiv.innerHTML = `<div class='alert alert-danger'>${data.mensagem}</div>`;
                mensagemDiv.hidden = false;
            }
            mensagemDiv.scrollIntoView({ behavior: 'smooth' });
        })
        .catch(error => {
            console.error("Erro ao alterar:", error);
        });
    });

    document.getElementById("formExcluir").addEventListener("submit", function(e) {

            e.preventDefault();

            const form = e.target;
            const formData = new FormData(form);

            fetch("/admin/usuario/excluir", {
                method: "POST",
                body: new URLSearchParams(formData)
            })
            .then(response => response.json())
            .then(data => {
                const mensagemDiv = document.getElementById("mensagemExcluir");
                if (data.status === "ok") {
                    mensagemDiv.innerHTML = "<div class='alert alert-success'>Usuário excluido com sucesso!</div>";
                    form.reset();
                    mensagemDiv.hidden = false;
                } else {
                    mensagemDiv.innerHTML = `<div class='alert alert-danger'>${data.mensagem}</div>`;
                }
                mensagemDiv.scrollIntoView({ behavior: 'smooth' });
            })
            .catch(error => {
                console.error("Erro ao excluir:", error);
            });
        });

    document.getElementById("formEntregaMaterial").addEventListener("submit", function(e) {
        e.preventDefault();

        const form = e.target;
        const formData = new FormData(form);

        fetch("/admin/usuario/entrega", {
            method: "POST",
            body: new URLSearchParams(formData)
        })
        .then(response => response.json())
        .then(data => {
            const mensagemDiv = document.getElementById("mensagemEntrega");
            if (data.status === "ok") {
                mensagemDiv.innerHTML = "<div class='alert alert-success'>Entrega cadastrada com sucesso!</div>";
                mensagemDiv.hidden = false;
                form.reset();
                let formAlterar = document.getElementById("formAlterarUsuario");
                formAlterar.hidden = true;
            } else {
                mensagemDiv.innerHTML = `<div class='alert alert-danger'>${data.mensagem}</div>`;
                mensagemDiv.hidden = false;
            }
            mensagemDiv.scrollIntoView({ behavior: 'smooth' });
        })
        .catch(error => {
            console.error("Erro ao alterar:", error);
        });
    });

    document.getElementById("formAtualizaEstoqueCestas").addEventListener("submit", function(e) {
            e.preventDefault();

            const form = e.target;
            const formData = new FormData(form);

            fetch("/admin/cestas/atualizar", {
                method: "POST",
                body: new URLSearchParams(formData)
            })
            .then(response => response.json())
            .then(data => {
                const mensagemDiv = document.getElementById("mensagemAtualizarEstoque");
                if (data.status === "ok") {
                    mensagemDiv.innerHTML = "<div class='alert alert-success'>Estoque atualizado com sucesso!</div>";
                    mensagemDiv.hidden = false;
                    form.reset();
                } else {
                    mensagemDiv.innerHTML = `<div class='alert alert-danger'>${data.mensagem}</div>`;
                    mensagemDiv.hidden = false;
                }
                mensagemDiv.scrollIntoView({ behavior: 'smooth' });
            })
            .catch(error => {
                console.error("Erro ao cadastrar:", error);
            });
        });




    document.getElementById("formCadastroMaterial").addEventListener("submit", function(e) {
            e.preventDefault();

            const form = e.target;
            const formData = new FormData(form);

            fetch("/admin/material/cadastro", {
                method: "POST",
                body: new URLSearchParams(formData)
            })
            .then(response => response.json())
            .then(data => {
                const mensagemDiv = document.getElementById("mensagemMaterial");
                if (data.status === "ok") {
                    mensagemDiv.innerHTML = "<div class='alert alert-success'>Material cadastrado com sucesso!</div>";
                    mensagemDiv.hidden = false;
                    form.reset();
                    let formAlterar = document.getElementById("formAlterarUsuario");
                    formAlterar.hidden = true;
                } else {
                    mensagemDiv.innerHTML = `<div class='alert alert-danger'>${data.mensagem}</div>`;
                    mensagemDiv.hidden = false;
                }
                mensagemDiv.scrollIntoView({ behavior: 'smooth' });
            })
            .catch(error => {
                console.error("Erro ao alterar:", error);
            });
        });

    document.addEventListener("DOMContentLoaded", function() {
    const tipoCesta = document.getElementById('tipoCesta');
    const quantidade = document.getElementById('quantidade');
    const totalCalculado = document.getElementById('totalCalculado');
    const valorGeradoTroca = document.getElementById('valorGeradoTroca');

    function calcularTotal() {
        const cestaSelecionada = tipoCesta.options[tipoCesta.selectedIndex];
        const valorUnitario = parseInt(cestaSelecionada.getAttribute('data-valor')) || 0;
        const qtd = parseInt(quantidade.value) || 0;
        const total = valorUnitario * qtd;


        totalCalculado.value = total + ' Créditos' ;


        valorGeradoTroca.value = total;
    }


    tipoCesta.addEventListener('change', calcularTotal);
    quantidade.addEventListener('input', calcularTotal);
    quantidade.addEventListener('change', calcularTotal);

    // Calcula inicialmente se já houver valores
    calcularTotal();
});

    document.getElementById("formTroca").addEventListener("submit", function(e) {
        e.preventDefault();

        const form = e.target;
        const formData = new FormData(form);

        fetch("/admin/troca", {
            method: "POST",
            body: new URLSearchParams(formData)
        })
        .then(response => response.json())
        .then(data => {
            const mensagemDiv = document.getElementById("mensagemTroca");
            if (data.status === "ok") {
                mensagemDiv.innerHTML = "<div class='alert alert-success'>Troca registrada com sucesso!</div>";
                mensagemDiv.hidden = false;
                form.reset();

            } else {
                mensagemDiv.innerHTML = `<div class='alert alert-danger'>${data.mensagem}</div>`;
                mensagemDiv.hidden = false;
            }
            mensagemDiv.scrollIntoView({ behavior: 'smooth' });
        })
        .catch(error => {
            console.error("Erro ao alterar:", error);
        });
    });


document.getElementById("entregas-tab").addEventListener("click", function(e) {

    fetch('admin/entregas/listar')
        .then(response => {
            if (!response.ok) throw response;
            return response.json();
        })
        .then(entregas => {
            const tbody = document.querySelector("#entregas tbody");
            tbody.innerHTML = ""; // Limpa a tabela

            entregas.forEach(entrega => {
                const row = `
                    <tr>
                        <td>${entrega.id}</td>
                        <td>${entrega.idUsuario}</td>
                        <td>${entrega.idMaterial}</td>
                        <td>${entrega.qtdEntregaKG}</td>
                        <td>${entrega.valorGeradoEntrega}</td>
                        <td>${entrega.dataEntrega}</td>
                    </tr>
                `;
                tbody.innerHTML += row;
            });
        })
        .catch(async error => {
            const err = await error.json().catch(() => ({ mensagem: "Erro desconhecido" }));
            alert("Erro ao carregar trocas: " + err.mensagem);
        });

});

document.getElementById("visualizar-cestas-tab").addEventListener("click", function(e) {

    fetch('admin/cestas/listar')
        .then(response => {
            if (!response.ok) throw response;
            return response.json();
        })
        .then(cestas => {
            const tbody = document.querySelector("#cestas tbody");
            tbody.innerHTML = ""; // Limpa a tabela

            cestas.forEach(cesta => {
                const row = `
                    <tr>
                        <td>${cesta.id}</td>
                        <td>${cesta.descricaoCesta}</td>
                        <td>${cesta.valorPorUnidade}</td>
                        <td>${cesta.qtdEstoque}</td>

                    </tr>
                `;
                tbody.innerHTML += row;
            });
        })
        .catch(async error => {
            const err = await error.json().catch(() => ({ mensagem: "Erro desconhecido" }));
            alert("Erro ao carregar trocas: " + err.mensagem);
        });

});

    document.getElementById("visualizar-materiais-tab").addEventListener("click", function(e) {

        fetch('admin/materiais/listar')
            .then(response => {
                if (!response.ok) throw response;
                return response.json();
            })
            .then(materiais => {
                const tbody = document.querySelector("#materiais tbody");
                tbody.innerHTML = ""; // Limpa a tabela

                materiais.forEach(material => {
                    const row = `
                        <tr>
                            <td>${material.id}</td>
                            <td>${material.tipoMaterial}</td>
                            <td>${material.valorPorPeso}</td>
                            <td>${material.qtdEstoqueKG}</td>

                        </tr>
                    `;

                 tbody.innerHTML += row;
                });
            })
            .catch(async error => {
                const err = await error.json().catch(() => ({ mensagem: "Erro desconhecido" }));
                alert("Erro ao carregar trocas: " + err.mensagem);
            });

    });

    document.getElementById("visualizar-trocas-tab").addEventListener("click", function(e) {

    fetch('admin/trocas/listar')
        .then(response => {
            if (!response.ok) throw response;
            return response.json();
        })
        .then(trocas => {
            const tbody = document.querySelector("#trocas tbody");
            tbody.innerHTML = ""; // Limpa a tabela

            trocas.forEach(troca => {
                const row = `
                    <tr>
                        <td>${troca.id}</td>
                        <td>${troca.idCesta}</td>
                        <td>${troca.qtdTroca}</td>
                        <td>${troca.valorGeradoTroca}</td>
                        <td>${troca.dataTroca}</td>
                        <td>${troca.idUsuario}</td>
                    </tr>
                `;

                tbody.innerHTML += row;
            });
        })
        .catch(async error => {
            const err = await error.json().catch(() => ({ mensagem: "Erro desconhecido" }));

        });

});

    let entregasCache = []; // Armazena todos os dados localmente

    function renderEntregas(entregas) {
        const tbody = document.querySelector("#entregas tbody");
        tbody.innerHTML = "";
        entregas.forEach(entrega => {
            const row = `
                <tr>
                    <td>${entrega.id}</td>
                    <td>${entrega.idUsuario}</td>
                    <td>${entrega.idMaterial}</td>
                    <td>${entrega.qtdEntregaKG}</td>
                    <td>${entrega.valorGeradoEntrega}</td>
                    <td>${entrega.dataEntrega}</td>
                </tr>
            `;
            tbody.innerHTML += row;
        });
    }

    function filtrarEntregas(valor) {
        const termo = valor.toLowerCase();
    const filtrados = entregasCache.filter(entrega =>
        String(entrega.idUsuario).toLowerCase().includes(termo)
    );
    renderEntregas(filtrados);
    }

    function carregarEntregas() {
        fetch('/admin/entregas/listar')
            .then(response => {
                if (!response.ok) throw response;
                return response.json();
            })
            .then(entregas => {
                entregasCache = entregas;
                renderEntregas(entregas);

            })
            .catch(async error => {
                const err = await error.json().catch(() => ({ mensagem: "Erro desconhecido" }));

            });
    }

    // Eventos
    document.addEventListener("DOMContentLoaded", carregarEntregas);
    document.getElementById("filtro-entregas").addEventListener("input", (e) => {
        console.log("tecla pressionada" + e.value);
        filtrarEntregas(e.target.value);
    });

    let trocasCache = []; // Armazena todos os dados localmente

    function renderTrocas(trocas) {
        const tbody = document.querySelector("#trocas tbody");
        tbody.innerHTML = "";
        trocas.forEach(troca => {
            const row = `
                <tr>
                    <td>${troca.id}</td>
                        <td>${troca.idCesta}</td>
                        <td>${troca.qtdTroca}</td>
                        <td>${troca.valorGeradoTroca}</td>
                        <td>${troca.dataTroca}</td>
                        <td>${troca.idUsuario}</td>
                </tr>
            `;
            tbody.innerHTML += row;
        });
    }

    function filtraTrocas(valor) {
        const termo = valor.toLowerCase();
    const filtrados = trocasCache.filter(troca =>
        String(troca.idUsuario).toLowerCase().includes(termo)
    );
    renderTrocas(filtrados);
    }

    function carregarTrocas() {
        fetch('/admin/trocas/listar')
            .then(response => {
                if (!response.ok) throw response;
                return response.json();
            })
            .then(trocas => {
                trocasCache = trocas;
                renderTrocas(trocas);

            })
            .catch(async error => {
                const err = await error.json().catch(() => ({ mensagem: "Erro desconhecido" }));
                alert("Erro ao carregar trocas: " + err.mensagem);
            });
    }

    // Eventos
    document.addEventListener("DOMContentLoaded", carregarTrocas);
    document.getElementById("filtro-trocas").addEventListener("input", (e) => {
        console.log("tecla pressionada" + e.value);
        filtraTrocas(e.target.value);
    });

