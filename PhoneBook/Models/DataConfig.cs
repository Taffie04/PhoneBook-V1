using Dapper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PhoneBook.Models
{
    public class DataConfig
    {
        private static IDbConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["PhoneBookEntities"].ConnectionString);

        public static List<Contact> getContacts()
        {
         
        string sql = @"	SELECT c.ContactId
		                   ,c.FirstName
		                   ,c.LastName
                           ,cd.ContactDetailId
		                   ,cd.ContactDetail
		                   ,ct.ContactDetailType
                        FROM [dbo].[Contacts] c
                        JOIN dbo.ContactDetail cd ON cd.ContactId = c.ContactId
                        JOIN dbo.ContactDetailType ct ON ct.ContactDetailTypeId = cd.ContactDetailType";

            var cmd = new CommandDefinition(sql, null, null, null, CommandType.Text, CommandFlags.Buffered, default(System.Threading.CancellationToken));


            var results = db.Query(sql, commandType: CommandType.Text);

            var ids = results.Select(x => new { x.ContactId, x.FirstName, x.LastName }).Distinct();

            List<Contact> gridResults = new List<Contact>();
            foreach (var el in ids)
            {
                var phoneNos = results.Where(x => x.ContactDetailType == "Phone" && x.ContactId == el.ContactId).Select(x => new Phone { PhoneNumber = x.ContactDetail, PhoneId = x.ContactDetailId, ContactId = x.ContactDetailId }).ToList();
                var emails = results.Where(x => x.ContactDetailType == "Email" && x.ContactId == el.ContactId).Select(x => new Email { EmailAddress = x.ContactDetail, EmailId = x.ContactDetailId, ContactId = x.ContactDetailId }).ToList();

                gridResults.Add(new Contact
                {
                    ContactId = el.ContactId,
                    FirstName = el.FirstName,
                    LastName = el.LastName,
                    EmailAddress = emails,
                    PhoneNumbers = phoneNos
                });
            }
            return gridResults;
        }

        public static bool saveUpdateContact(Contact contact, Operation operation)
        {
            try
            {
                DataTable dte = new DataTable();
                DataTable dp = new DataTable();
                DataColumn dc = new DataColumn("ContactDetail", typeof(string));
                DataColumn dcc = new DataColumn("ContactDetail", typeof(string));
                dte.Columns.Add(dc);
                dp.Columns.Add(dcc);

                var ems = contact.EmailAddress.Select(a => a.EmailAddress);
                var pn = contact.PhoneNumbers.Select(a => a.PhoneNumber);
                //dte.Rows.Add(ems);
                //dp.Rows.Add(pn);

                foreach (var rest in ems)
                {
                    dte.Rows.Add(rest);
                }
                foreach (var rest in pn)
                {
                    dp.Rows.Add(rest);
                }

                var p = new DynamicParameters();
                p.Add("@FirstName", contact.FirstName);
                p.Add("@LastName", contact.LastName);
                p.Add("@ListOfEmail",dte.AsTableValuedParameter());
                p.Add("@ListOfPhoneNumbers", dp.AsTableValuedParameter());

                if (operation == Operation.Update)
                    p.Add("@ContactId", contact.ContactId);

                db.Execute("spAddUpdateContact", p, commandType: CommandType.StoredProcedure);

                return true;
            }
            catch (Exception e)
            {
                //do logging
                return false;
            }
        }

        public static Contact getContactById(int contactId )
        {
            return DataConfig.getContacts().Where(a => a.ContactId == contactId).FirstOrDefault();
        }

        public static void deleteContact()
        {

        }
    }
}