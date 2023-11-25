-- Define a custom type for cart status
CREATE TYPE cart_status AS ENUM ('OPEN', 'ORDERED');

-- Create a table for shopping carts
CREATE TABLE shopping_carts (
    id UUID PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    created_at DATE NOT NULL,
    updated_at DATE NOT NULL,
    status cart_status NOT NULL
);

-- Create a table for cart items
CREATE TABLE cart_items (
    id UUID NOT NULL PRIMARY KEY,
    cart_id UUID REFERENCES shopping_carts(id),
    product_id UUID,
    quantity INTEGER
);

-- Insert sample data into the tables
INSERT INTO shopping_carts (id, user_id, created_at, updated_at, status) VALUES
    ('11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', '2023-11-13', '2023-11-13', 'ORDERED'),
    ('33333333-3333-3333-3333-333333333333', '44444444-4444-4444-4444-444444444444', '2023-11-13', '2023-11-13', 'ORDERED'),
    ('55555555-5555-5555-5555-555555555555', '66666666-6666-6666-6666-666666666666', '2023-11-13', '2023-11-13', 'OPEN'),
    ('77777777-7777-7777-7777-777777777777', '88888888-8888-8888-8888-888888888888', '2023-11-13', '2023-11-13', 'OPEN');

INSERT INTO cart_items (id, cart_id, product_id, quantity) VALUES
    ('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '99999999-9999-9999-9999-999999999999', 2),
    ('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '33333333-3333-3333-3333-333333333333', '88888888-8888-8888-8888-888888888888', 5),
    ('ccccccc3-cccc-cccc-cccc-cccccccccccc', '55555555-5555-5555-5555-555555555555', '77777777-7777-7777-7777-777777777777', 4),
    ('ddddddd4-dddd-dddd-dddd-dddddddddddd', '77777777-7777-7777-7777-777777777777', '66666666-6666-6666-6666-666666666666', 18);
