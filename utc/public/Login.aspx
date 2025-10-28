<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Account_Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style>
       body {
		font-family: 'Varela Round', sans-serif;
	}
	.modal-login {		
		color: #636363;
		width: 350px;
        position:relative;
        
        
	}
	.modal-login .modal-content {
		padding: 20px;
		border-radius: 5px;
		border: none;
       
	}
	.modal-login .modal-header {
		border-bottom: none;   
        position: relative;
        justify-content: center;
	}
	.modal-login h4 {
		text-align: center;
		font-size: 26px;
		margin: 15px 0 -15px;
	}
	.modal-login .form-control:focus {
		border-color: #70c5c0;
	}
	.modal-login .form-control, .modal-login .btn {
		min-height: 40px;
		border-radius: 3px; 
	}
	.modal-login .close {
        position: relative;
		top: -5px;
		right: -5px;
	}	
	.modal-login .modal-footer {
		background: #ecf0f1;
		border-color: #dee4e7;
		text-align: center;
        justify-content: center;
		margin: 0 -20px -20px;
		border-radius: 5px;
		font-size: 13px;
	}
	.modal-login .modal-footer a {
		color: #999;
	}		
	.modal-login .avatar {
		position: absolute;
		margin: 0 auto;
		left: 0;
		right: 0;
		top: -70px;
		width: 95px;
		height: 95px;
		border-radius: 50%;
		z-index: 9;
		background-color:#d51317;
		padding: 15px;
		box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
	}
	.modal-login .avatar img {
		width: 100%;
	}
	.modal-login.modal-dialog {
		margin-top: 80px;
	}
    .modal-login .btn {
        color: #fff;
        border-radius: 4px;
		background: #003F85;
		text-decoration: none;
		transition: all 0.4s;
        line-height: normal;
        border: none;
    }
	.modal-login .btn:hover, .modal-login .btn:focus {
		background: #FF0000;
		outline: none;
	}
	.trigger-btn {
		display: inline-block;
		margin: 100px auto;
	}
    .imgRedonda {
    width:220px;
    height:65px;
    border-radius:140px;
}
 
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
    <div class="col-sm-12 col-md-12 col-lg-4"></div>

   
    
    <div class="col-sm-12 col-md-12 col-lg-4">

        <asp:Login ID="LoginUser" runat="server" HyperLinkStyle-HorizontalAlign="Center" EnableViewState="False" FailureText="Revise el usuario o contraseña está incorrecto.  Inténtelo de nuevo.">
            <LayoutTemplate>

                <div id="myModal">
                    <div class="modal-dialog modal-login">
                        <div class="modal-content">
                            <div class="modal-header">
                                <div class="avatar ">
                                    <img src="avatar.png" class="imgRedonda" alt="Avatar" />
                                </div>
                                <h4 class="modal-title">Ingrese sus credenciales</h4>
                                <div class="col-sm-12 col-md-12 col-lg-12">
                                    <br />
                                    <asp:Label ID="lblMsg" CssClass="alert-danger" runat="server" Text=""></asp:Label>
                                </div>
                                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
                            </div>
                            <div class="modal-body">

                                <div class="form-group">
                                    <asp:TextBox ID="UserName"  Placeholder="Ingrese Ci / Pass" CssClass="form-control" runat="server" Font-Size="0.8em"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" CssClass="alert-danger" ErrorMessage="El nombre de usuario es obligatorio." ToolTip="El nombre de usuario es obligatorio." ValidationGroup="LoginUser" ForeColor="Red">Obligatorio *</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group">
                                    <asp:TextBox ID="Password" runat="server" CssClass="form-control" Placeholder="Ingrese la contraseña"  Font-Size="0.8em" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" CssClass="alert-danger" ErrorMessage="La contraseña es obligatoria." ToolTip="La contraseña es obligatoria." ValidationGroup="LoginUser" ForeColor="Red">Obligatorio *</asp:RequiredFieldValidator>
                                    
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="LoginButton" runat="server"  CommandName="Login" CssClass="btn btn-primary btn-lg btn-block login-btn" OnClick="LoginButton_Click2" Text="Inicio de sesión" ValidationGroup="LoginUser"  />
                                </div>

                            </div>
                            <div class="modal-footer">
                                <a href="/sigutc/academic/public/recoverypwd.aspx" target="_blank">Olvido su contraseña?</a>
                            </div>
                        </div>
                    </div>
                </div>
            </LayoutTemplate>
        </asp:Login>
    </div>
     

    <div class="col-sm-12 col-md-12 col-lg-12">
        <br />
    </div>
     <div class="col-sm-12 col-md-12 col-lg-4">

    </div>
    <div class="col-sm-12 col-md-12 col-lg-12" style="text-align:center">
        <a href="https://drive.google.com/file/d/1zBZJ1H1jxUPDD2nPmWl0sEe5Ubu-Ix-O/view" target="_blank">GUÍA DE MATRÍCULA</a>

    </div>

    <div class="col-sm-12 col-md-12 col-lg-3">

    </div>

</asp:Content>
