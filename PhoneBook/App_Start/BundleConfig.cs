using System.Web;
using System.Web.Optimization;

namespace PhoneBook
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-3.3.1.min.js"
                        // "~/Scripts/jquery.dataTables.min.js"
                        ));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                     "~/Scripts/bootstrap.js",
                     "~/Scripts/popper.min.js",
                     "~/Scripts/mdb.js",
                      "~/Scripts/addons/datatables.min.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                "~/Content/all.css",
                 "~/Content/font-awesome.css",
                "~/Content/bootstrap.css",
                "~/Content/mdb.min.css",
                "~/Content/style.css",
                 "~/Content/addons/datatables.min.css"
                ));
        }
    }
}
