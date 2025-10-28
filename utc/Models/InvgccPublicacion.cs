using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace utc.Models
{
    public class InvgccPublicacion
    {
       
            [JsonProperty("strId_publi")]
            public string strId_publi { get; set; }

        [JsonProperty("strCodigoIes_publi")]
        public string IdCodIes { get; set; }

        [JsonProperty("strRevPares_publi")]
        public string Pares { get; set; }

        [JsonProperty("strTituloclib_publi")]
        public string strTituloclib_publi { get; set; }

        [JsonProperty("strEditorcompiladorclib_publi")]
        public string strEditorcompiladorclib_publi { get; set; }
        

             [JsonProperty("strEdicionEven_publi")]
        public string strEdicionEven_publi { get; set; }
        [JsonProperty("strPaginasclib_publi")]
        public string strPaginasclib_publi { get; set; }

        
            [JsonProperty("strAnio_publi")]
        public string strAnio_publi { get; set; }

        [JsonProperty("strTipo_publi")]
            public string TipoPubli { get; set; }

            [JsonProperty("strTitulo_publi")]
            public string TituloPubli { get; set; }

            [JsonProperty("strTipoarti_publi")]
            public string TipoArticuloPubli { get; set; }

            [JsonProperty("strCodigopubli_publi")]
            public string CodigoPubliPubli { get; set; }

            [JsonProperty("strBddindeaxada_publi")]
            public string BddIndeaxadaPubli { get; set; }

        [JsonProperty("strRegImp_publi")]
        public string strRegImp_publi { get; set; }
        

            [JsonProperty("strCodigoissnn_publi")]
            public string CodigoISSNNPubli { get; set; }

            [JsonProperty("strNombre_publi")]
            public string NombrePubli { get; set; }

            [JsonProperty("strNumero_publi")]
            public string NumeroPubli { get; set; }
        [JsonProperty("strnombrerevis_publi")]
        public string strnombrerevis_publi { get; set; }

        
              [JsonProperty("strNumr_publi")]
        public string strNumr_publi { get; set; }

        [JsonProperty("strSjr_publi")]
            public string SjrPubli { get; set; }

            [JsonProperty("dtFecha_publi")]
            public DateTime dtFecha_publi { get; set; }

            [JsonProperty("strCampodetallado_publi")]
            public string CampoDetalladoPubli { get; set; }

            [JsonProperty("strEstado_publi")]
            public string EstadoPubli { get; set; }

            [JsonProperty("strLink_publi")]
            public string LinkPubli { get; set; }

            [JsonProperty("strLinkrevista_publi")]
            public string LinkRevistaPubli { get; set; }

            [JsonProperty("strFiliacion_publi")]
            public string FiliacionPubli { get; set; }

            [JsonProperty("strIdentificacionparti_publi")]
            public string IdentificacionPartiPubli { get; set; }

            [JsonProperty("strNombreparti_publi")]
            public string NombrePartiPubli { get; set; }

            [JsonProperty("strParticipacion_publi")]
            public string ParticipacionPubli { get; set; }

            [JsonProperty("strRevisadoreslib_publi")]
            public string RevisadoresLibPubli { get; set; }

            [JsonProperty("strNombreponenciam_publi")]
            public string NombrePonenciaMPubli { get; set; }

            [JsonProperty("strNombreEven_publi")]
            public string strNombreEven_publi { get; set; }
        
            [JsonProperty("strOrganizadoreseventom_publi")]
            public string OrganizadoresEventoMPubli { get; set; }
            [JsonProperty("strComiteOrgam_publi")]
            public string strComiteOrgam_publi { get; set; }
        

            [JsonProperty("strPaism_publi")]
            public string PaisMPubli { get; set; }

            [JsonProperty("strCiudadm_publi")]
            public string CiudadMPubli { get; set; }
        }



    
}