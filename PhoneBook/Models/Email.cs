using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneBook.Models
{
    public class Email
    {
        public int EmailId { get; set; }
        public int ContactId { get; set; }
        public string EmailAddress { get; set; }
        public int DeleteEmail { get; set; }

        public virtual Contact Contact { get; set; }
    }
}