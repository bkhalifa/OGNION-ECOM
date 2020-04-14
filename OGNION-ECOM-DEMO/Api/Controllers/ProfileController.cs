
using System.Collections.Generic;
using System.Linq;

using Api.Model;
using ECOM.Repos.DB;
using Microsoft.AspNetCore.Mvc;


namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProfileController : ControllerBase
    {
        [HttpGet]
        [Route("all")]
        public ActionResult<List<ProfileModel>> GetAllUsers()
        {
            using (var ctx = new COMMERCEContext())
            {
                var querCustumer = (from c in ctx.CustumerUser
                                    join r in ctx.CustomerRole on c.CustumerRoleId equals r.CustumerRoleId
                                    select new ProfileModel
                                    {
                                        Id = c.CustumerId,
                                        FirstName = c.CustumerName,
                                        LastName = c.CustumerLastName,
                                        UserName = c.Customerlogin,
                                        Role = r.CustumerRole
                                    }).ToList();

                return Ok(querCustumer);

            }

        }

        [HttpPost]
        [Route("login")]
        public ActionResult<ProfileModel> LoginCustumer([FromBody]LoginModel model)
        {
            using (var ctx = new COMMERCEContext())
            {
                var foundCustumer = (from c in ctx.CustumerUser
                                     join r in ctx.CustomerRole on c.CustumerRoleId equals r.CustumerRoleId
                                     where c.Customerlogin == model.Login && c.Custumerpassword == model.PassWord
                                     select new ProfileModel
                                     {
                                         Id = c.CustumerId,
                                         FirstName = c.CustumerName,
                                         LastName = c.CustumerLastName,
                                         UserName = c.Customerlogin,
                                         Role = r.CustumerRole
                                     }).FirstOrDefault();

                if(foundCustumer != null)
                    return Ok(foundCustumer);

                return Ok();
            }

        }

        [HttpGet("{id}")]
        public ActionResult GetById(int id)
        {
            using (var ctx = new COMMERCEContext())
            {
                var Custumer = (from c in ctx.CustumerUser
                                join r in ctx.CustomerRole on c.CustumerRoleId equals r.CustumerRoleId
                                where c.CustumerId == id
                                select new ProfileModel
                                {
                                    Id = c.CustumerId,
                                    FirstName = c.CustumerName,
                                    LastName = c.CustumerLastName,
                                    Role = r.CustumerRole
                                }).FirstOrDefault();


                return Ok(Custumer);
            }

        }


        [HttpPost]
        [Route("updateuser")]
        public ActionResult UpdateUser([FromBody]ProfileModel userModel)
        {
            if (userModel != null)
            {
                using (var ctx = new COMMERCEContext())
                {
                    var foundUser = ctx.CustumerUser
                         .Where(u => u.CustumerId == userModel.Id)
                         .Select(u => new CustumerUser
                         {
                             CustumerId = userModel.Id,
                             Customerlogin = userModel.UserName,
                             CustumerLastName = userModel.LastName,
                             CustumerName = userModel.FirstName,
                             Custumerpassword = u.Custumerpassword,
                             CustumerRoleId = (userModel.Role.Equals("admin")) ? 1 : 2

                         })
                         .FirstOrDefault();

                    if (foundUser != null)
                    {
                        ctx.CustumerUser.Update(foundUser);
                        ctx.SaveChanges();
                        return Ok(true);
                    }
                 
                }
            }
            return Ok(false);
        }

    }
}