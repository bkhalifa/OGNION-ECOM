using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ECOM.Repos.DB
{
    public partial class COMMERCEContext : DbContext
    {
        public COMMERCEContext()
        {
        }

        public COMMERCEContext(DbContextOptions<COMMERCEContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Categories> Categories { get; set; }
        public virtual DbSet<CustomerRole> CustomerRole { get; set; }
        public virtual DbSet<CustumerUser> CustumerUser { get; set; }
        public virtual DbSet<OrderDetails> OrderDetails { get; set; }
        public virtual DbSet<Orders> Orders { get; set; }
        public virtual DbSet<Products> Products { get; set; }
        public virtual DbSet<Reviews> Reviews { get; set; }
        public virtual DbSet<ShoppingCart> ShoppingCart { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=DESKTOP-QB4PK8M\\DEV;Database=COMMERCE;User Id= sa; Password=bilel ;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.4-servicing-10062");

            modelBuilder.Entity<Categories>(entity =>
            {
                entity.HasKey(e => e.CategoryId)
                    .ForSqlServerIsClustered(false);

                entity.Property(e => e.CategoryId).HasColumnName("CategoryID");

                entity.Property(e => e.CategoryName).HasMaxLength(50);
            });

            modelBuilder.Entity<CustomerRole>(entity =>
            {
                entity.HasKey(e => e.CustumerRoleId)
                    .HasName("PK__Customer__9AE41682A0D547E2");

                entity.Property(e => e.CustumerRoleId)
                    .HasColumnName("custumerRoleId")
                    .ValueGeneratedNever();

                entity.Property(e => e.CustumerRole)
                    .HasColumnName("custumerRole")
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<CustumerUser>(entity =>
            {
                entity.HasKey(e => e.CustumerId)
                    .HasName("PK__Custumer__36343601DFBCD409");

                entity.Property(e => e.CustumerId)
                    .HasColumnName("custumerId")
                    .ValueGeneratedNever();

                entity.Property(e => e.Customerlogin)
                    .HasColumnName("customerlogin")
                    .HasMaxLength(80);

                entity.Property(e => e.CustumerLastName)
                    .HasColumnName("custumerLastName")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.CustumerName)
                    .HasColumnName("custumerName")
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.CustumerRoleId).HasColumnName("custumerRoleID");

                entity.Property(e => e.Custumerpassword)
                    .HasColumnName("custumerpassword")
                    .HasMaxLength(120);

                entity.HasOne(d => d.CustumerRole)
                    .WithMany(p => p.CustumerUser)
                    .HasForeignKey(d => d.CustumerRoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_custumerRoleID");
            });

            modelBuilder.Entity<OrderDetails>(entity =>
            {
                entity.Property(e => e.OrderId).HasColumnName("OrderID");

                entity.Property(e => e.ProductId).HasColumnName("ProductID");

                entity.Property(e => e.UnitCost).HasColumnType("money");

                entity.HasOne(d => d.Order)
                    .WithMany(p => p.OrderDetails)
                    .HasForeignKey(d => d.OrderId)
                    .HasConstraintName("FK_Order_OrderDetails");
            });

            modelBuilder.Entity<Orders>(entity =>
            {
                entity.HasKey(e => e.OrderId)
                    .ForSqlServerIsClustered(false);

                entity.Property(e => e.OrderId).HasColumnName("OrderID");

                entity.Property(e => e.CustomerName)
                    .IsRequired()
                    .HasMaxLength(256);

                entity.Property(e => e.OrderDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.ShipDate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");
            });

            modelBuilder.Entity<Products>(entity =>
            {
                entity.HasKey(e => e.ProductId)
                    .ForSqlServerIsClustered(false);

                entity.HasIndex(e => e.ModelName)
                    .HasName("ci_product_modelname")
                    .ForSqlServerIsClustered();

                entity.Property(e => e.ProductId).HasColumnName("ProductID");

                entity.Property(e => e.CategoryId).HasColumnName("CategoryID");

                entity.Property(e => e.Description).HasMaxLength(3800);

                entity.Property(e => e.ModelName).HasMaxLength(50);

                entity.Property(e => e.ModelNumber).HasMaxLength(50);

                entity.Property(e => e.ProductImage).HasMaxLength(50);

                entity.Property(e => e.UnitCost).HasColumnType("money");

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.CategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Products_Categories");
            });

            modelBuilder.Entity<Reviews>(entity =>
            {
                entity.HasKey(e => e.ReviewId);

                entity.Property(e => e.ReviewId).HasColumnName("ReviewID");

                entity.Property(e => e.Comments).HasMaxLength(3850);

                entity.Property(e => e.CustomerEmail).HasMaxLength(50);

                entity.Property(e => e.CustomerName).HasMaxLength(50);

                entity.Property(e => e.ProductId).HasColumnName("ProductID");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Reviews_Products");
            });

            modelBuilder.Entity<ShoppingCart>(entity =>
            {
                entity.HasKey(e => e.RecordId)
                    .ForSqlServerIsClustered(false);

                entity.HasIndex(e => new { e.CartId, e.ProductId })
                    .HasName("IX_ShoppingCart");

                entity.Property(e => e.RecordId).HasColumnName("RecordID");

                entity.Property(e => e.CartId)
                    .HasColumnName("CartID")
                    .HasMaxLength(50);

                entity.Property(e => e.DateCreated)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.ProductId).HasColumnName("ProductID");

                entity.Property(e => e.Quantity).HasDefaultValueSql("((1))");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.ShoppingCart)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ShoppingCart_Products");
            });
        }
    }
}
