using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace utc.Models
{
    public class InvgccPublicacionDetalle
    {
        // Propiedades para INVGCCPUBLICACION_DETALLE
        

        [JsonProperty("id_publicacion_detalle")]
        public string IdPublicacion_Detalle { get; set; }

        [JsonProperty("id_publicacion")]
        public string IdPublicacion { get; set; }

        [JsonProperty("strIdentificacionparti_publi")]
        public string IdentificacionParticipacionPublicacion { get; set; }

        [JsonProperty("strNombreparti_publi")]
        public string NombreParticipacionPublicacion { get; set; }

        [JsonProperty("strParticipacion_publi")]
        public string ParticipacionPublicacion { get; set; }

        [JsonProperty("strFiliacion_publi")]
        public string FiliacionPublicacion { get; set; }

       
    }
}