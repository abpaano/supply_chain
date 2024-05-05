<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('tbl_supply_chain', function (Blueprint $table) {
            $table->id();
            $table->string("product_name");
            $table->string("category");
            $table->integer("quantity");
            $table->double("price");
            $table->string("unit");
            $table->string("produced_from");
            $table->string("description");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tbl_supply_chain');
    }
};
