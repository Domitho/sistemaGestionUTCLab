<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InsPro.aspx.cs" Inherits="utc.InsPro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="prueba/Styles/datatables/datatables.css" rel="stylesheet" />

    <script src="prueba/Scripts/datatables/datatables.js"></script>
    <script src="prueba/Scripts/datatables/datatables.min.js"></script>



    <!-- EXPORTAR PDF EXCEL -->
    <script src="prueba/Scripts/datatables_imprimir/pdfmake.min.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/print.js"></script>
    <script src="prueba/Scripts/datatables_imprimir/vfs_fonts.js"></script>
    <script src="prueba/Scripts/propias/datatablesMetodo.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-fileinput@5.1.0/dist/css/fileinput.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-fileinput@5.1.0/dist/js/fileinput.min.js"></script>


    <link href="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/bootstrap.tagsinput/0.8.0/bootstrap-tagsinput.min.js"></script>



    <%-- estilos propios para boton redondo--%>
    <link href="prueba/Styles/propio/propio.css" rel="stylesheet" />

    <script type="text/javascript">//para mostrar splash screen
        window.addEventListener('load', function () {
            $(".loading").css("display", "none");
        });


    </script>




    <div class="loading">Loading&#8230;</div>

    <%--<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>--%>
    <script src="https://cdn.ckeditor.com/4.18.0/full/ckeditor.js"></script>
    <div class="row">
        <div class="col-md-12 text-center">


            <asp:Panel ID="Panel1" runat="server" BackColor="White" Width="100%">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <div class="col-md-4 text-center">
                            <%--<asp:button Cssclass="btn btn btn-bitbucket text-center" style="border-radius: 100px; width: 214px; height: 52px;"  BackColor="#312783" ForeColor="White" Font-Bold="True" runat="server" Text="UTC"  ID="btnUtc" ClientIDMode="Static" ToolTip="UNIVERSIDAD TÉCNICA DE COTOPAXI..." Font-Size="25px"> </asp:button>--%>
                            <%-- <label class="" style="color: #312783; font-size:25px;">UTC</label>--%>
                        </div>
                        <div class="col-md-4 text-center">
                            <h3 style="color: #312783; font-weight: bold;"><i class="fa fa-book"></i>SISTEMA DE GESTIÓN GENERAL DE INVESTIGACIÓN
                            </h3>
                        </div>
                        <div class="col-md-4 text-center">
                            <asp:LinkButton CssClass="btn btn btn-bitbucket text-center" CausesValidation="false" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" runat="server" Text="<span><i class='fa fa-chevron-left'></i></span> REGRESAR" BackColor="#312783" ForeColor="White" Font-Bold="True" ID="btnRegresarInsPro" ToolTip="REGRESAR..." Font-Size="20px" Visible="false" OnClick="btnRegresarInsPro_Click"> </asp:LinkButton>
                            <asp:Label ID="lblPath" runat="server" Visible="false"></asp:Label>
                        </div>
                    </div>
                </div>
            </asp:Panel>


            <br />
            <asp:Panel ID="pnlVerProyecto" runat="server" Style="background-color: aliceblue" Visible="false">

                <asp:Label ID="lblMostrarProyecto" runat="server" Font-Bold="true"></asp:Label>
            </asp:Panel>
            <%--    <asp:Button ID="btnCrearCabeceraAcad" runat="server" Text="Nuevo Registo" OnClick="btnCrearCabeceraAcad_Click" CssClass="btn btn-bitbucket " Style="border-radius: 100px;" />--%>
            <asp:Label ID="codigo" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            <br />

            <div class="text-right">
            </div>

        </div>
    </div>
    <div class="col-md-12 text-center">

        <asp:LinkButton runat="server" ID="lbtNuevoInsPro" CausesValidation="false" CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" BackColor="#312783" ForeColor="White" Font-Bold="True" OnClick="lbtNuevoInsPro_Click">Agregar Nuevo</asp:LinkButton>


        <asp:Panel runat="server" ID="pnlGrilla">
            <br />


            <br />
            <div class="table table-responsive text-center" style="background-color: #F5F5F5;">
                <asp:GridView runat="server" ID="gvwListadoInsPro" CssClass="cabeza table table-bordered table-hover table-responsive text-center" OnRowDataBound="gvwListadoInsPro_RowDataBound" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                    <Columns>


                        <asp:BoundField DataField="strId_pro" HeaderText="COD" ItemStyle-Width="15px" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                        <asp:BoundField DataField="strArchivo_pro" HeaderText="TEMA PRO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />

                        <asp:BoundField DataField="strTema_pro" HeaderText="TEMA PRO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strDuracion_pro" HeaderText="DURACIÓN PRO" HtmlEncode="false" ItemStyle-CssClass="html" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="dtFehains_pro" HeaderText="FECHA INSCRIPCIÓN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strEstado_pro" HeaderText="ESTADO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strNombre_gru" HeaderText="GRUPO" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strNombre_conv" HeaderText="CONVOCATORIA" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />


                        <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnVisualizarInsPro" CausesValidation="false" runat="server" CssClass="btn btn-info btn-xs btn-circle" Text="<span class='glyphicon glyphicon-paperclip'></span>" OnClick="btnVisualizarInsPro_Click" ToolTip="Visualizar Adjunto." Style="color: white;" />
                                <asp:LinkButton ID="btnActividades" CausesValidation="false" runat="server" CssClass="btn btn-success btn-xs btn-circle" Text="<span class='glyphicon glyphicon-list-alt'></span>" OnClick="btnActividades_Click" ToolTip="Visualizar Actividades." Style="color: white;" />
                                <asp:LinkButton ID="btnEditarInsPro" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-edit'></span>" OnClick="btnEditarInsPro_Click" ToolTip="Editar Registro." Style="color: white;" />
                                <asp:LinkButton ID="btnBorrarInsPro" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarInsPro_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                                <%--ELIMINANDO REGISTRO DE LA BDD --%>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <AlternatingRowStyle BackColor="White" />

                    <EditRowStyle BackColor="#004289" />
                    <EmptyDataTemplate>
                        SIN REGISTROS
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                    <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />

                    <SelectedRowStyle BackColor="Yellow" BorderColor="Black" VerticalAlign="Middle" CssClass="font-weight-bold" />

                    <SortedAscendingCellStyle BackColor="#004289" />
                    <SortedAscendingHeaderStyle BackColor="#004289" />
                    <SortedDescendingCellStyle BackColor="#004289" />
                    <SortedDescendingHeaderStyle BackColor="#004289" />
                </asp:GridView>
            </div>
        </asp:Panel>


    </div>


    <asp:Panel runat="server" ID="pnlAgregarInsPro" Visible="false">

        <div class="row">
            <div class="col-md-12 text-center form-control">
                Agregando Inscripción de proyectos...
            </div>
        </div>
        <br />

        <div class="row">
            <div class="col-md-3">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione el grupo</asp:Label>
                <asp:DropDownList ID="ddlGrupo" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvGrupo" runat="server" ControlToValidate="ddlGrupo" ErrorMessage="Seleccione el grupo" CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>

            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el Tema del proyecto</asp:Label>
                <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el tema del proyecto..." Width="100%" ID="strTemaInsPro" Style="align-content: center"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTemaInsPro" runat="server" ControlToValidate="strTemaInsPro" ErrorMessage="Ingrese el tema del proyecto" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-5" style="background-color: aliceblue;">
                <div class="row">
                    <div class="col-md-8">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el tiempo de duración</asp:Label>
                        <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el tiempo de duración del proyecto.." ID="strDuracionInsPro" TextMode="Number" Width="100%" Style="align-content: center"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDuracionInsPro" runat="server" ControlToValidate="strDuracionInsPro" ErrorMessage="Ingrese el tiempo de duración del proyecto" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-4">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*seleccione*</asp:Label>
                        <asp:DropDownList ID="ddlDuracion" runat="server" CssClass="form-control">

                            <asp:ListItem Value="meses">Meses</asp:ListItem>
                            <asp:ListItem Value="años">Años</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

           





            <hr style="border: solid; color: #F0AD4E;" />

            <div class="row">
                <div class="col-md-12 text-center">
                    <br />
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la fecha</asp:Label>
                        <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la fecha de creación.." TextMode="DateTimeLocal" Width="100%" ID="dtFechaCreacion"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFechaCreacion" runat="server" ControlToValidate="dtFechaCreacion" ErrorMessage="Seleccione la fecha de creación" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Adjunte la inscripción</asp:Label>
                        <asp:FileUpload ID="flpInscripcion" runat="server" CssClass="file-input" accept=".xls, .xlsx, application/pdf" />
                        <asp:RequiredFieldValidator ID="rfvInscripcion" runat="server" data-show-preview="true" data-show-upload="true" ControlToValidate="flpInscripcion" ErrorMessage="Adjunte la inscripción" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la convocatoria</asp:Label>
                        <asp:DropDownList ID="ddlConvocatoria" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvConvocatoria" runat="server" ControlToValidate="ddlConvocatoria" ErrorMessage="Seleccione la convocatoria" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione el estado</asp:Label>
                        <asp:DropDownList ID="ddlEstadoInsPro" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="APROBADO">APROBADO</asp:ListItem>
                            <asp:ListItem Value="PENDIENTE">PENDIENTE</asp:ListItem>
                            <asp:ListItem Value="NO APROBADO">NO APROBADO</asp:ListItem>
                            <asp:ListItem Value="CERRADO">CERRADO</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvEstadoInsPro" runat="server" ControlToValidate="ddlEstadoInsPro" ErrorMessage="Seleccione el estado" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 text-center">
                    <br />
                    <br />
                    <asp:LinkButton ID="lbtADDInsPro" OnClientClick="return validarDuracion();" runat="server" CssClass="btn btn-success" OnClick="lbtADDInsPro_Click" Style="color: white; border-radius: 100px;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; CREAR REGISTRO" />
                    <asp:LinkButton ID="lbtCancelarGruInv" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="color: white; border-radius: 100px;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtCancelarGruInv_Click" />
                    <br />
                    <br />
                </div>
            </div>
    </asp:Panel>



    <asp:Panel runat="server" ID="pnlEditPro" Visible="false">
        <!-- Contenido del Panel -->
        <div class="row">
            <div class="col-md-12 text-center form-control">
                Editando Inscripción de proyectos...
            </div>
        </div>
        <br />

        <div class="row">
            <div class="col-md-12 text-center">
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione el grupo</asp:Label>
                    <asp:DropDownList ID="ddlGrupoEdit" Enabled="false" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                    </asp:DropDownList>
                    <!-- RequiredFieldValidator para ddlGrupoEdit -->
                    <%--  <asp:RequiredFieldValidator ID="rfvGrupoEdit" runat="server" ControlToValidate="ddlGrupoEdit" ErrorMessage="Seleccione un grupo" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </div>

                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el Tema del proyecto</asp:Label>
                    <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el tema del proyecto..." Width="100%" ID="txtEditTemaPro"></asp:TextBox>
                    <!-- RequiredFieldValidator para txtEditTemaPro -->
                    <asp:RequiredFieldValidator ID="rfvTemaPro" runat="server" ControlToValidate="txtEditTemaPro" ErrorMessage="Ingrese el tema del proyecto" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-5" style="background-color: aliceblue;">
                    <div class="row">
                        <div class="col-md-8">
                            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Ingrese el tiempo de duración</asp:Label>
                            <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese el tiempo de duración del proyecto.." ID="txtEditTiempoPRO" Width="100%"></asp:TextBox>
                            <!-- RequiredFieldValidator para txtEditTiempoPRO -->
                            <asp:RequiredFieldValidator ID="rfvTiempoPro" runat="server" ControlToValidate="txtEditTiempoPRO" ErrorMessage="Ingrese el tiempo de duración del proyecto" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-4">
                            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">*seleccione*</asp:Label>
                            <asp:DropDownList ID="ddlEditDuracion" runat="server" CssClass="form-control">
                                <asp:ListItem Value="meses">Meses</asp:ListItem>
                                <asp:ListItem Value="años">Años</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                    </div>
                </div>
                <hr style="border: solid; color: #F0AD4E;" />
                <div class="row">
                    <br />
                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la fecha</asp:Label>
                        <asp:TextBox runat="server" CssClass="text-center form-control" placeholder="Por favor ingrese la fecha de creación.." TextMode="DateTimeLocal" Width="100%" ID="dtEditFechaCrea"></asp:TextBox>
                        <!-- RequiredFieldValidator para dtEditFechaCrea -->
                        <asp:RequiredFieldValidator ID="rfvFechaCrea" runat="server" ControlToValidate="dtEditFechaCrea" ErrorMessage="Seleccione la fecha de creación" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>

                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Adjunte la inscripción</asp:Label>
                        <asp:FileUpload ID="flpEditIns" runat="server" accept=".xls, .xlsx, application/pdf" />
                        <asp:Label runat="server" ForeColor="Red" ID="txtNombreArchivo"></asp:Label>

                    </div>

                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione la convocatoria</asp:Label>
                        <asp:DropDownList ID="ddlEditConv" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                        </asp:DropDownList>
                        <!-- RequiredFieldValidator para ddlEditConv -->
                        <asp:RequiredFieldValidator ID="rfvEditConv" runat="server" ControlToValidate="ddlEditConv" ErrorMessage="Seleccione la convocatoria" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>

                    <div class="col-md-3">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">Seleccione el estado</asp:Label>
                        <asp:DropDownList ID="ddlEditEstadoPro" CssClass="form-control text-center" runat="server" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                            <asp:ListItem Value="APROBADO">APROBADO</asp:ListItem>
                            <asp:ListItem Value="PENDIENTE">PENDIENTE</asp:ListItem>
                            <asp:ListItem Value="NO APROBADO">NO APROBADO</asp:ListItem>
                            <asp:ListItem Value="CERRADO">CERRADO</asp:ListItem>
                        </asp:DropDownList>
                        <!-- RequiredFieldValidator para ddlEditEstadoPro -->
                        <asp:RequiredFieldValidator ID="rfvEstadoPro" runat="server" ControlToValidate="ddlEditEstadoPro" ErrorMessage="Seleccione el estado" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
                 </div>
             </div>



                <div class="row">
                    <div class="col-md-12 text-center">

                        <br />
                        <br />
                        <asp:LinkButton ID="LbtnEditPro"  runat="server" CssClass="btn btn-success" OnClick="LbtnEditPro_Click" Style="color: white; border-radius: 100px;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; EDITAR REGISTRO" />
                        <asp:LinkButton ID="lbtnCancellPro" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="color: white; border-radius: 100px;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtnCancellPro_Click" />
                        <br />
                        <br />
                    </div>
                </div>
    </asp:Panel>




    <div class="col-md-12 text-center">
        <asp:Label runat="server" ID="lblIdProyecto" ForeColor="Red"></asp:Label>
        <asp:Label runat="server" ID="lblResult" ForeColor="Red"></asp:Label>
    </div>
    <asp:Panel runat="server" ID="pnlActividades" Visible="false">
        <div class="col-md-12 text-center">


            <asp:LinkButton runat="server" ID="lblNuevaActividad" CausesValidation="false" CssClass="btn btn btn-bitbucket text-center" Style="border-radius: 100px; width: 260px; height: 47px; font-weight: bold;" BackColor="#312783" ForeColor="White" Font-Bold="True" OnClick="lblNuevaActividad_Click">Agregar Nueva Actividad</asp:LinkButton>

            <br />
            <br />
            <asp:HiddenField ID="hdnSumaTotal" runat="server" />
            <style>
                .gridview-container {
                    position: relative;
                    min-height: 200px; /* Ajusta esta altura según sea necesario */
                }

                .gridview-footer {
                    position: absolute;
                    bottom: 0;
                    width: 100%;
                }
            </style>
            <div id="gridview-container" class="table table-responsive">
                <asp:GridView ID="gvwActividades" DataKeyNames="strId_act" OnRowDataBound="gvwActividades_RowDataBound1" runat="server" ClientIDMode="Static" ShowFooter="true" CssClass="cabeza table table-bordered table-hover table-responsive text-center" ForeColor="#333333" GridLines="Horizontal" HorizontalAlign="Center" AutoGenerateColumns="false" ToolTip="registros...">
                    <Columns>
                        <asp:BoundField DataField="strId_act" HeaderText="COD" ItemStyle-Width="15px" FooterStyle-CssClass="ocultar" ItemStyle-Wrap="true" ItemStyle-Font-Size="X-Small" ReadOnly="true" Visible="true" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                        <asp:BoundField DataField="strArchivo_act" HeaderText="NOMBRE ACT" FooterStyle-CssClass="ocultar" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar" />
                        <asp:BoundField DataField="strNombre_act" HeaderText="NOMBRE ACT" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="strDescripcion_act" HeaderText="DESCRIPCIÓN ACT" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="dtFechaini_act" HeaderText="FECHA INI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="dtFechafinal_act" HeaderText="FECHA FIN" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                        <asp:BoundField DataField="decCosto_act" HeaderText="COSTO INI" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                       <%-- <asp:BoundField DataField="strInsumos_pro" HeaderText="RECURSOS" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />

                        <asp:BoundField DataField="decPrecio_pro2" HeaderText="PRECIO RECURSOS" FooterText="TOTAL:" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" />
                    --%>    <asp:BoundField DataField="decValortotal_act" HeaderText="VALOR TOTAL" ItemStyle-Font-Size="Small" HeaderStyle-Font-Size="Small" FooterStyle-CssClass="mostrar-precio" />

                        <asp:TemplateField HeaderText="ACCIONES" HeaderStyle-Font-Size="Small">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnVisualizarAct" CausesValidation="false" runat="server" CssClass="btn btn-info btn-xs btn-circle" Text="<span class='glyphicon glyphicon-paperclip'></span>" OnClick="btnVisualizarAct_Click" ToolTip="Visualizar Adjunto." Style="color: white;" />
                                <asp:LinkButton ID="btnEditarAct" CausesValidation="false" runat="server" CssClass="btn btn-warning btn-xs btn-circle" Text="<span class='glyphicon glyphicon-pencil'></span>" OnClick="btnEditarAct_Click" ToolTip="Visualizar Adjunto." Style="color: white;" />
                                <asp:LinkButton ID="btnBorrarAct" CausesValidation="false" runat="server" Text="<span class='glyphicon glyphicon-trash'></span>" CssClass="btn btn-danger btn-xs btn-circle" OnClick="btnBorrarAct_Click" Style="color: white;" OnClientClick="return confirm('Esta seguro que desea eliminar este registro, esta opción es irreversible?')" ToolTip="Eliminar registro." />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <AlternatingRowStyle BackColor="White" />
                    <EditRowStyle BackColor="#004289" />
                    <EmptyDataTemplate>
                        SIN REGISTROS
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />

                    <HeaderStyle BackColor="#004289" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#004289" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                </asp:GridView>

            </div>

        </div>


        <%-- <script>
            $(document).ready(function () {
                if ($('#gvwActividades').find('tbody tr').length > 0) {
                    var total = 0;

                    // Recorre cada fila del GridView y suma el valor de decValortotal_act
                    $('#gvwActividades').find('tbody tr').each(function () {
                        var precio = parseFloat($(this).find('td:eq(8)').text());
                        if (!isNaN(precio)) {
                            total += precio;
                        }
                    });

                    // Obtener la fila del footer del GridView
                    var footerRow = $('#gvwActividades').find('tfoot tr').first();

                    // Obtener la celda correspondiente al total en el footerRow
                    var cellTotal = footerRow.find('td:eq(8)');

                    // Establecer el valor total en la celda del footer
                    cellTotal.text(total.toFixed(2));

                    // Agregar la clase "mostrar-precio" a la celda del footer
                    cellTotal.addClass('mostrar-precio');

                    // Mover el footer al final del GridView
                    $('#gvwActividades').append(footerRow);
                }
            });


        </script>--%>





        <%--<script>
   
</script>--%>
    </asp:Panel>

    <br />
    <asp:Panel ID="pnlAgregarAct" runat="server" Visible="false">
        <div class="row">
            <div class="col-md-12 text-center form-control">
                Agregando Actividades Asociadas...
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12 text-center">
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">NOMBRE DE LA ACTIVIDAD</asp:Label>
                    <asp:TextBox ID="txtNombreAct" runat="server" CssClass="form-control" placeholder="Ingrese el nombre de la actividad"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombreAct" runat="server" ControlToValidate="txtNombreAct" ErrorMessage="Ingrese el nombre de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">DESCRIPCIÓN</asp:Label>
                    <asp:TextBox ID="txtDescripcionAct" runat="server" CssClass="form-control" placeholder="Ingrese descripción de la actividad"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDescripcionAct" runat="server" ControlToValidate="txtDescripcionAct" ErrorMessage="Ingrese descripción de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FECHA INICIO</asp:Label>
                    <asp:TextBox ID="dtFechaIniAct" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFechaIniAct" runat="server" ControlToValidate="dtFechaIniAct" ErrorMessage="Seleccione la fecha de inicio" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FECHA FIN</asp:Label>
                    <asp:TextBox ID="dtFechaFinAct" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFechaFinAct" runat="server" ControlToValidate="dtFechaFinAct" ErrorMessage="Seleccione la fecha de fin" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <hr style="border: solid; color: #F0AD4E;" />
       <%-- <div class="col-md-12 text-center">
            <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">¿DESEA AGREGAR RECURSOS?</asp:Label>
            <asp:RadioButton runat="server" RepeatDirection="Horizontal" ID="rblPreguntarAgregarInsumosOK" Text="SI" OnCheckedChanged="rblPreguntarAgregarInsumosOK_CheckedChanged" AutoPostBack="true" />
            <asp:RadioButton runat="server" RepeatDirection="Horizontal" ID="rblPreguntarAgregarInsumosNO" Text="NO" OnCheckedChanged="rblPreguntarAgregarInsumosNO_CheckedChanged" AutoPostBack="true" />
        </div>--%>
        <asp:Panel runat="server" ID="pnlAddRecursos" Visible="false">
            <div class="col-md-12 text-center" style="background-color: aliceblue;">
                <div class="col-md-6 text-center">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">INGRESE LOS RECURSOS</asp:Label><br />
                    <asp:TextBox ID="txtTagsRecursos" runat="server" CssClass="form-control" Style="width: 100%;" data-role="tagsinput" placeholder="Ingrese los Recusos que desee seguidos de (,)"></asp:TextBox>

                </div>
                <div class="col-md-6 text-center">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">PRECIO FINAL</asp:Label>
                    <asp:TextBox ID="fltPrecioRecAct" runat="server" CssClass="form-control" placeholder="Ingrese el precio total de los Recusos" TextMode="Number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPrecioTotAct" runat="server" ControlToValidate="fltPrecioRecAct" ErrorMessage="Ingrese el precio total de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
        </asp:Panel>
        <div class="col-md-12 text-center">
            <br />
            <br />
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">COSTOS DE ACTIVIDAD</asp:Label>
                <asp:TextBox ID="fltPrecioAct" runat="server" CssClass="form-control" placeholder="Ingrese costo de la actividad" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPrecioAct" runat="server" ControlToValidate="fltPrecioAct" ErrorMessage="Ingrese el costo de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">ADJUNTAR ARCHIVO</asp:Label>
                <asp:FileUpload runat="server" ID="flpAdjuntoAct" accept=".xls, .xlsx, application/pdf" />

                <asp:RequiredFieldValidator ID="rfvAdjuntoAct" runat="server" ControlToValidate="flpAdjuntoAct" ErrorMessage="Adjunte un archivo" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <div class="col-md-4">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">ESTADO</asp:Label>
                <asp:DropDownList runat="server" ID="ddlEstadoAct" CssClass="form-control text-center" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                    <asp:ListItem Value="VALIDADO">VALIDADO</asp:ListItem>
                    <asp:ListItem Value="PENDIENTE DE VALIDACIÓN">PENDIENTE DE VALIDACIÓN</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvEstadoAct" runat="server" ControlToValidate="ddlEstadoAct" ErrorMessage="Seleccione el estado" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <%--<div class="col-md-3">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">PRECIO FINAL</asp:Label>
                <asp:TextBox ID="fltPrecioTotAct" runat="server" CssClass="form-control" placeholder="Ingrese el precio total de la actividad" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPrecioTotAct" runat="server" ControlToValidate="fltPrecioTotAct" ErrorMessage="Ingrese el precio total de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>--%>
        </div>
        <div class="col-md-12 text-center">
            <br />

            <asp:LinkButton ID="lbtnAddAct" runat="server" CssClass="btn btn-success" OnClick="lbtnAddAct_Click" Style="color: white; border-radius: 100px;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; CREAR REGISTRO" />
            <asp:LinkButton ID="lbtCancelAct" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="color: white; border-radius: 100px;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR REGISTRO" OnClick="lbtCancelAct_Click" />
            <br />
            <br />
        </div>

    </asp:Panel>

    <asp:Panel ID="pnlEditarActividades" runat="server" Visible="false">
        <div class="row">
            <div class="col-md-12 text-center form-control">
                Editando Actividades Asociadas...
            </div>
        </div>
        <br />
        <div class="row">
            <div class="col-md-12 text-center">
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">NOMBRE DE LA ACTIVIDAD</asp:Label>
                    <asp:TextBox ID="txtEditNombreAct" runat="server" CssClass="form-control" placeholder="Ingrese el nombre de la actividad"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEditNombreAct" runat="server" ControlToValidate="txtEditNombreAct" ErrorMessage="Ingrese el nombre de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">DESCRIPCIÓN</asp:Label>
                    <asp:TextBox ID="txtEditDescAct" runat="server" CssClass="form-control" placeholder="Ingrese descripción de la actividad"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEditDescAct" runat="server" ControlToValidate="txtEditDescAct" ErrorMessage="Ingrese la descripción de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FECHA INICIO</asp:Label>
                    <asp:TextBox ID="dtFechaInicioEdit" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFechaInicioEdit" runat="server" ControlToValidate="dtFechaInicioEdit" ErrorMessage="Ingrese la fecha de inicio" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">FECHA FIN</asp:Label>
                    <asp:TextBox ID="dtFechaFinEdit" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFechaFinEdit" runat="server" ControlToValidate="dtFechaFinEdit" ErrorMessage="Ingrese la fecha de fin" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>
            <hr style="border: solid; color: #F0AD4E;" />
           <%-- <div class="col-md-12 text-center">
                <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">¿DESEA AGREGAR RECURSOS?</asp:Label>
                <asp:RadioButton runat="server" RepeatDirection="Horizontal" ID="rblPreguntarEditInsumosOK" Text="SI" OnCheckedChanged="rblPreguntarEditInsumosOK_CheckedChanged" AutoPostBack="true" />
                <asp:RadioButton runat="server" RepeatDirection="Horizontal" ID="rblPreguntarEditnsumosNO" Text="NO" OnCheckedChanged="rblPreguntarEditnsumosNO_CheckedChanged" AutoPostBack="true" />
            </div>--%>
            <asp:Panel runat="server" ID="pnlEditInsumosAct" Visible="false">
                <div class="col-md-12 text-center" style="background-color: aliceblue;">
                    <div class="col-md-6 text-center">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">INGRESE LOS RECURSOS</asp:Label><br />
                        <asp:TextBox ID="txtEditRecursosAct" runat="server" CssClass="form-control" Style="width: 100%;" data-role="tagsinput" placeholder="Ingrese los Recusos que desee seguidos de (,)"></asp:TextBox>

                    </div>
                    <div class="col-md-6 text-center">
                        <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">PRECIO FINAL</asp:Label>
                        <asp:TextBox ID="txtPrecioEditAct" runat="server" CssClass="form-control" placeholder="Ingrese el precio total de los Recusos" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPrecioFinalEdt" runat="server" ControlToValidate="txtPrecioEditAct" ErrorMessage="Ingrese el precio total de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </asp:Panel>
            <div class="col-md-12 text-center">
                <br />
                <br />
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">COSTO DE ACTIVIDAD</asp:Label>
                    <asp:TextBox ID="fltprecioEdit" runat="server" CssClass="form-control" placeholder="Ingrese el costo de la actividad" TextMode="Number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPrecioEdit" runat="server" ControlToValidate="fltprecioEdit" ErrorMessage="Ingrese el costo de la actividad" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">ADJUNTAR ARCHIVO</asp:Label>
                    <asp:FileUpload runat="server" ID="flpEditActividad" accept=".xls, .xlsx, application/pdf" />

                </div>
                <div class="col-md-4">
                    <asp:Label runat="server" ForeColor="#312783" Font-Bold="true">ESTADO</asp:Label>
                    <asp:DropDownList runat="server" ID="ddlEstadoEditAct" CssClass="form-control text-center" Width="100%" BackColor="#F0AD4E" ForeColor="White">
                        <asp:ListItem Value="VALIDADO">VALIDADO</asp:ListItem>
                        <asp:ListItem Value="PENDIENTE DE VALIDACIÓN">PENDIENTE DE VALIDACIÓN</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvEstadoEditAct" runat="server" ControlToValidate="ddlEstadoEditAct" ErrorMessage="Seleccione el estado" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

            </div>
        </div>
        <div class="col-md-12 text-center">
            <br />

            <asp:LinkButton ID="LbtnEditarAct" runat="server" CssClass="btn btn-success" OnClick="lbtnEditAct_Click" Style="color: white; border-radius: 100px;" Text="&lt;span class='glyphicon glyphicon-floppy-disk'&gt;&lt;/span&gt; EDITAR REGISTRO" />
            <asp:LinkButton ID="lbtnCancellEditAct" CausesValidation="false" runat="server" CssClass="btn btn-danger" Style="color: white; border-radius: 100px;" Text="&lt;span class='glyphicon glyphicon-ban-circle'&gt;&lt;/span&gt; CANCELAR EDICIÓN" OnClick="lbtnCancellEditAct_Click" />
            <br />
            <br />
        </div>
    </asp:Panel>


</asp:Content>
