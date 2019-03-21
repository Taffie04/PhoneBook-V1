using PhoneBook.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Dapper;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace PhoneBook.Controllers
{
    public class ContactController : Controller
    {
        private IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["PhoneBookEntities"].ConnectionString);
        // GET: Contact
        public async Task<ActionResult> Index()
        {
            return View(DataConfig.getContacts());
        }

        // GET: Contact/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Contact/Create
        public ActionResult Create()
        {
            var contact = new Contact();
            contact.CreatePhoneNumbers(1);
            contact.CreateEmailAddress(1);
            return View(contact);
        }

        // POST: Contact/Create
        [HttpPost]
        public ActionResult Create([Bind(Include = "FirstName,LastName,EmailAddress,PhoneNumbers")] Contact contact)
        {
            try
            {

                DataConfig.saveUpdateContact(contact, Operation.Add);
                return Redirect("Index");
            }
            catch(Exception e)
            {
                return View();
            }
        }

        // GET: Contact/Edit/5
        public ActionResult Edit(int id)
        {
            var contact = DataConfig.getContactById(id);

            if (contact == null)
            {
                return HttpNotFound();
            }
            return View(contact);
        }

        // POST: Contact/Edit/5
        [HttpPost]
        public ActionResult Edit([Bind(Include = "ContactId,FirstName,LastName,EmailAddress,PhoneNumbers")] Contact contact)
        {
            try
            {
                DataConfig.saveUpdateContact(contact, Operation.Update);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Contact/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Contact/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
