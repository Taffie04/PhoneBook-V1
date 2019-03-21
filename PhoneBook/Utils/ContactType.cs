using System.ComponentModel;

namespace PhoneBook.Utils
{
    public enum  ContactType
    {
        [Description("Cellphone or landline number")]
        Phone,
        [Description("Email Address")]
        Email,
        [Description("Fax number")]
        Fax

    }
}