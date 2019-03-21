using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneBook.Models
{
    public class Phone
    {
        public int PhoneId { get; set; }
        public int ContactId {get;set;}
        public string PhoneNumber { get; set; }
        public int DeletePhone { get; set; }

        public virtual Contact Contact { get; set; }

    }
}