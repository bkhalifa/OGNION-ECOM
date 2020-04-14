using System;
using System.Collections.Generic;

namespace ECOM.Repos.DB
{
    public partial class CustumerUser
    {
        public int CustumerId { get; set; }
        public string CustumerName { get; set; }
        public string CustumerLastName { get; set; }
        public string Customerlogin { get; set; }
        public string Custumerpassword { get; set; }
        public int CustumerRoleId { get; set; }

        public virtual CustomerRole CustumerRole { get; set; }
    }
}
