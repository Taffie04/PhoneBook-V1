using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PhoneBook.Models
{
    public partial class Contact
    {
        public Contact()
        {
            this.PhoneNumbers = new HashSet<Phone>();
            //this.PhoneNumbers = new List<Phone>();
            this.EmailAddress = new List<Email>();
        }

        public Contact(int contactID, string firstName, string lastName, List<Email> email, List<Phone> phone) {
            this.ContactId = contactID;
            this.FirstName = firstName;
            this.LastName = lastName;
            this.EmailAddress = email;
            this.PhoneNumbers = phone;
        }

        public int ContactId { get; set; }
        [Display(Name = "First Name")]
        public string FirstName { get; set; }
        [Display(Name = "Last Name")]
        public string LastName { get; set; }
        [Display(Name = "Email")]
        public virtual ICollection<Email> EmailAddress { get; set; }
        [Display(Name = "Phone Number")]
        public virtual ICollection<Phone> PhoneNumbers { get; set; }

        internal void CreatePhoneNumbers(int count = 1)
        {
            for (int i = 0; i < count; i++)
            {
                PhoneNumbers.Add(new Phone());
            }
        }

        internal void CreateEmailAddress(int count = 1)
        {
            for (int i = 0; i < count; i++)
            {
                EmailAddress.Add(new Email());
            }
        }

    }
}