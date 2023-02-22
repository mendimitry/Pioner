using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace WebApplication1;

public partial class MaindataContext : DbContext
{
    public MaindataContext()
    {
    }

    public MaindataContext(DbContextOptions<MaindataContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Test> Tests { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlite("Data Source=bin\\Debug\\net6.0\\maindata.db");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Test>(entity =>
        {
            entity.ToTable("test");

            entity.HasIndex(e => e.Id, "IX_test_id").IsUnique();

            entity.HasIndex(e => e.PhoneNumber, "IX_test_phone_number").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.DateTime).HasColumnName("date_time");
            entity.Property(e => e.PhoneNumber).HasColumnName("phone_number");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
