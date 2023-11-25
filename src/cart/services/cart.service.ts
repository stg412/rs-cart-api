import { Injectable } from '@nestjs/common';

import { v4 } from 'uuid';

import { Cart } from '../models';
import { lookup } from 'src/db/helper';

@Injectable()
export class CartService {
  private userCarts: Record<string, Cart> = {};

  async findByUserId(userId: string) {
    const query = `SELECT id, items
    from( SELECT id , user_id, ( SELECT to_json(array_agg(row_to_json(ci)))
                   from (SELECT * from cart_items where cart_id=c.id) ci ) items
          from carts c where c.user_id = '${userId}'
          group by id ) cartitmes`;
    const cart = await lookup(query);
    return cart;
  }

  async createByUserId(userId: string) {
    const query = `INSERT INTO cart(userId) VALUES(${userId}) RETURNING *`;

    const userCart = await lookup(query);
    return userCart;
  }

  async findOrCreateByUserId(userId: string) {
    const userCart = await this.findByUserId(userId);

    if (userCart) {
      return userCart;
    }

    return this.createByUserId(userId);
  }

  async updateByUserId(userId: string, { items }: Cart) {
    const query = `UPDATE cart_items SET items = ${items} where id = '${userId} RETURNING *`;

    return await lookup(query);
  }

  removeByUserId(userId): void {
    const query = `DELETE FROM carts WHERE userId = ${userId};`;

    lookup(query);
  }

}