using System;
using System.Collections.Generic;

namespace ECOM.Repos.DB
{
    public partial class CustomerRole
    {
        public CustomerRole()
        {
            CustumerUser = new HashSet<CustumerUser>();
        }

        public int CustumerRoleId { get; set; }
        public string CustumerRole { get; set; }

        public virtual ICollection<CustumerUser> CustumerUser { get; set; }
    }
}
