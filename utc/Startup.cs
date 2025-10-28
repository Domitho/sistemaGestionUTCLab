using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(utc.Startup))]
namespace utc
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
